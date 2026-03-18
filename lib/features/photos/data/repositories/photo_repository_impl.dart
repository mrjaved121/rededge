import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:red_edge_app/features/jobs/domain/entities/photo_entity.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/sync/sync_manager.dart';
import '../../domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiClient _api;
  final SyncManager _syncManager;
  final _uuid = const Uuid();

  PhotoRepositoryImpl({
    required ApiClient api,
    required SyncManager syncManager,
  })  : _api = api,
        _syncManager = syncManager;

  @override
  Future<Either<Failure, PhotoEntity>> savePhoto({
    required String jobId,
    required String stepId,
    required String localPath,
    double? latitude,
    double? longitude,
    String? address,
    String? annotation,
  }) async {
    try {
      final response = await _api.uploadPhoto(localPath, {
        'jobId': jobId,
        'stepId': stepId,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        if (address != null) 'address': address,
        if (annotation != null) 'annotation': annotation,
      });

      final data = response.data as Map<String, dynamic>;
      final photo = data['photo'] as Map<String, dynamic>? ?? data;

      return Right(PhotoEntity(
        id: photo['_id']?.toString() ?? _uuid.v4(),
        jobId: jobId,
        stepId: stepId,
        localPath: localPath,
        remoteUrl: photo['filePath'] as String?,
        thumbnailUrl: photo['thumbnailUrl'] as String?,
        latitude: latitude,
        longitude: longitude,
        address: photo['address'] as String? ?? address,
        annotation: annotation,
        capturedAt: DateTime.now(),
        isSynced: true,
      ));
    } on DioException {
      // Save locally when offline — enqueue for later upload
      final localId = _uuid.v4();
      _syncManager.enqueue(
        type: 'upload_photo',
        payload: {
          'localPath': localPath,
          'jobId': jobId,
          'stepId': stepId,
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
          if (address != null) 'address': address,
          if (annotation != null) 'annotation': annotation,
        },
      );
      return Right(PhotoEntity(
        id: localId,
        jobId: jobId,
        stepId: stepId,
        localPath: localPath,
        latitude: latitude,
        longitude: longitude,
        address: address,
        annotation: annotation,
        capturedAt: DateTime.now(),
        isSynced: false,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhotoEntity>>> getPhotosForStep(
    String jobId,
    String stepId,
  ) async {
    try {
      final response = await _api.dio.get('/photos', queryParameters: {
        'jobId': jobId,
        'stepId': stepId,
      });
      final data = response.data as Map<String, dynamic>;
      final photosRaw = data['photos'] as List<dynamic>? ?? [];
      return Right(photosRaw.map((p) {
        final pm = p as Map<String, dynamic>;
        return PhotoEntity(
          id: pm['_id']?.toString() ?? '',
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
              ? DateTime.tryParse(pm['capturedAt'].toString()) ?? DateTime.now()
              : DateTime.now(),
          isSynced: true,
        );
      }).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhoto(String photoId) async {
    try {
      await _api.dio.delete('/photos/$photoId');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
