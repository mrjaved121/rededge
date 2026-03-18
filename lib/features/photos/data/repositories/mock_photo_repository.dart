import 'package:fpdart/fpdart.dart';
import 'package:red_edge_app/features/jobs/domain/entities/photo_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:red_edge_app/core/error/failures.dart';
import 'package:red_edge_app/features/photos/domain/repositories/photo_repository.dart';

class MockPhotoRepository implements PhotoRepository {
  final List<PhotoEntity> _photos = [];

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
    await Future.delayed(const Duration(milliseconds: 300));

    final photo = PhotoEntity(
      id: const Uuid().v4(),
      jobId: jobId,
      stepId: stepId,
      localPath: localPath,
      latitude: latitude,
      longitude: longitude,
      annotation: annotation,
      capturedAt: DateTime.now(),
      isSynced: false,
    );

    _photos.add(photo);
    return Right(photo);
  }

  @override
  Future<Either<Failure, List<PhotoEntity>>> getPhotosForStep(
      String jobId,
      String stepId,
      ) async {
    final result = _photos
        .where((p) => p.jobId == jobId && p.stepId == stepId)
        .toList();
    return Right(result);
  }

  @override
  Future<Either<Failure, void>> deletePhoto(String photoId) async {
    _photos.removeWhere((p) => p.id == photoId);
    return const Right(null);
  }
}