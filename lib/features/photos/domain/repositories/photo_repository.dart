import 'package:fpdart/fpdart.dart';
import 'package:red_edge_app/features/jobs/domain/entities/photo_entity.dart';
import '../../../../core/error/failures.dart';

abstract class PhotoRepository {
  Future<Either<Failure, PhotoEntity>> savePhoto({
    required String jobId,
    required String stepId,
    required String localPath,
    double? latitude,
    double? longitude,
    String? address,
    String? annotation,
  });

  Future<Either<Failure, List<PhotoEntity>>> getPhotosForStep(
      String jobId,
      String stepId,
      );

  Future<Either<Failure, void>> deletePhoto(String photoId);
}