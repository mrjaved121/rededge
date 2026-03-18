import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/hive_service.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/entities/step_entity.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/repositories/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final ApiClient _api;

  const JobRepositoryImpl({required ApiClient api}) : _api = api;

  Box get _settingsBox => HiveService.getBox(HiveService.settingsBox);

  Map<String, dynamic> _deepCast(dynamic data) {
    if (data is Map) {
      return data.map((k, v) {
        final key = k.toString();
        if (v is Map) return MapEntry(key, _deepCast(v));
        if (v is List) return MapEntry(key, v.map((e) => e is Map ? _deepCast(e) : e).toList());
        return MapEntry(key, v);
      });
    }
    return {};
  }

  JobEntity _parseJob(Map<String, dynamic> json) {
    final stepsRaw = json['steps'] as List<dynamic>? ?? [];
    final jobId = json['_id']?.toString() ?? json['id']?.toString() ?? '';
    final steps = stepsRaw.asMap().entries.map((entry) {
      final s = entry.value as Map<String, dynamic>;
      final stepId =
          s['id']?.toString() ?? s['_id']?.toString() ?? entry.key.toString();
      final photosRaw = s['photos'] as List<dynamic>? ?? [];
      return StepEntity(
        id: stepId,
        number: s['number'] as int? ?? (entry.key + 1),
        title: s['title'] as String? ?? '',
        description: s['description'] as String?,
        requiresPhoto: s['requiresPhoto'] as bool? ?? false,
        isCompleted: s['isCompleted'] as bool? ?? false,
        notes: s['notes'] as String?,
        photos: photosRaw.map((p) {
          if (p is String) {
            return PhotoEntity(
              id: p,
              jobId: jobId,
              stepId: stepId,
              localPath: p,
              capturedAt: DateTime.now(),
            );
          }
          final pm = p as Map<String, dynamic>;
          return PhotoEntity(
            id: pm['_id']?.toString() ?? pm['id']?.toString() ?? '',
            jobId: jobId,
            stepId: stepId,
            localPath: pm['filePath'] as String? ?? '',
            remoteUrl: pm['filePath'] as String?,
            thumbnailUrl: pm['thumbnailUrl'] as String?,
            latitude: (pm['latitude'] as num?)?.toDouble(),
            longitude: (pm['longitude'] as num?)?.toDouble(),
            address: pm['address'] as String?,
            annotation: pm['annotation'] as String?,
            capturedAt: pm['capturedAt'] != null
                ? DateTime.tryParse(pm['capturedAt'].toString()) ??
                    DateTime.now()
                : DateTime.now(),
            isSynced: true,
          );
        }).toList(),
      );
    }).toList();

    final completedSteps = steps.where((s) => s.isCompleted).length;

    String? assignedToId;
    String? assignedToName;
    final assignedTo = json['assignedTo'];
    if (assignedTo is Map<String, dynamic>) {
      assignedToId =
          assignedTo['_id']?.toString() ?? assignedTo['id']?.toString();
      assignedToName = assignedTo['name'] as String?;
    } else if (assignedTo is String) {
      assignedToId = assignedTo;
    }

    return JobEntity(
      id: jobId,
      jobNumber: json['jobNumber'] as String? ?? '',
      title: json['title'] as String? ?? '',
      status: JobStatusX.fromApi(json['status'] as String? ?? 'draft'),
      systemType: json['systemType'] as String? ?? 'Other',
      location: json['location'] as String? ?? '',
      address: json['address'] as String? ?? '',
      date: json['scheduledDate'] != null
          ? DateTime.tryParse(json['scheduledDate'].toString()) ??
              DateTime.now()
          : DateTime.now(),
      completedSteps: completedSteps,
      totalSteps: steps.length,
      steps: steps,
      company: json['company'] as String? ?? '',
      assignedToId: assignedToId,
      assignedToName: assignedToName,
      description: json['description'] as String?,
    );
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getJobs({
    JobStatus? statusFilter,
    String? systemFilter,
  }) async {
    try {
      final response = await _api.getJobs(
        status: statusFilter?.apiValue,
        system: systemFilter,
      );
      final data = response.data as Map<String, dynamic>;
      final jobsRaw = data['jobs'] as List<dynamic>? ?? [];
      final jobs =
          jobsRaw.map((j) => _parseJob(j as Map<String, dynamic>)).toList();
      // Cache for offline use
      try { _settingsBox.put('cached_jobs', response.data); } catch (_) {}
      return Right(jobs);
    } on DioException catch (e) {
      // Fallback to Hive cache when offline
      try {
        final cached = _settingsBox.get('cached_jobs');
        if (cached != null) {
          final data = _deepCast(cached);
          final jobsRaw = data['jobs'] as List<dynamic>? ?? [];
          return Right(jobsRaw.map((j) => _parseJob(_deepCast(j))).toList());
        }
      } catch (_) {}
      final msg = e.response?.data?['error'] as String? ?? 'Failed to load jobs';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> getJobDetail(String jobId) async {
    try {
      final response = await _api.getJobDetail(jobId);
      final data = response.data as Map<String, dynamic>;
      final jobData = data['job'] as Map<String, dynamic>? ?? data;
      // Cache for offline use
      try { _settingsBox.put('cached_job_$jobId', jobData); } catch (_) {}
      return Right(_parseJob(jobData));
    } on DioException catch (e) {
      // Fallback to Hive cache when offline
      try {
        final cached = _settingsBox.get('cached_job_$jobId');
        if (cached != null) return Right(_parseJob(_deepCast(cached)));
      } catch (_) {}
      final msg = e.response?.data?['error'] as String? ?? 'Failed to load job';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> createJob(
      Map<String, dynamic> data) async {
    try {
      final response = await _api.createJob(data);
      final respData = response.data as Map<String, dynamic>;
      final jobData = respData['job'] as Map<String, dynamic>? ?? respData;
      return Right(_parseJob(jobData));
    } on DioException catch (e) {
      final msg =
          e.response?.data?['error'] as String? ?? 'Failed to create job';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> updateJob(
      String jobId, Map<String, dynamic> data) async {
    try {
      final response = await _api.updateJob(jobId, data);
      final respData = response.data as Map<String, dynamic>;
      final jobData = respData['job'] as Map<String, dynamic>? ?? respData;
      return Right(_parseJob(jobData));
    } on DioException catch (e) {
      final msg =
          e.response?.data?['error'] as String? ?? 'Failed to update job';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJob(String jobId) async {
    try {
      await _api.deleteJob(jobId);
      return const Right(null);
    } on DioException catch (e) {
      final msg =
          e.response?.data?['error'] as String? ?? 'Failed to delete job';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> updateJobStatus(
      String jobId, String status) async {
    try {
      final response = await _api.updateJobStatus(jobId, status);
      final respData = response.data as Map<String, dynamic>;
      final jobData = respData['job'] as Map<String, dynamic>? ?? respData;
      return Right(_parseJob(jobData));
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] as String? ??
          'Failed to update job status';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeStep(
    String jobId,
    String stepId, {
    String? notes,
  }) async {
    try {
      await _api.completeStep(jobId, stepId, {
        'isCompleted': true,
        if (notes != null) 'notes': notes,
      });
      return const Right(null);
    } on DioException catch (e) {
      final msg =
          e.response?.data?['error'] as String? ?? 'Failed to complete step';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addNotes(
    String jobId,
    String stepId,
    String notes,
  ) async {
    try {
      await _api.completeStep(jobId, stepId, {'notes': notes});
      return const Right(null);
    } on DioException catch (e) {
      final msg =
          e.response?.data?['error'] as String? ?? 'Failed to add notes';
      return Left(ServerFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
