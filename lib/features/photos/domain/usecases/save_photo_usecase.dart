import 'package:fpdart/fpdart.dart';
import 'package:red_edge_app/features/jobs/domain/entities/photo_entity.dart';
import '../../../../core/error/failures.dart';
import '../repositories/photo_repository.dart';

class SavePhotoUseCase {
  final PhotoRepository _repository;

  const SavePhotoUseCase(this._repository);

  Future<Either<Failure, PhotoEntity>> call({
    required String jobId,
    required String stepId,
    required String localPath,
    double? latitude,
    double? longitude,
    String? annotation,
  }) {
    return _repository.savePhoto(
      jobId: jobId,
      stepId: stepId,
      localPath: localPath,
      latitude: latitude,
      longitude: longitude,
      annotation: annotation,
    );
  }
}