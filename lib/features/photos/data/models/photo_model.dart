import 'package:hive/hive.dart';
import 'package:red_edge_app/features/jobs/domain/entities/photo_entity.dart';

@HiveType(typeId: 2)
class PhotoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String jobId;

  @HiveField(2)
  final String stepId;

  @HiveField(3)
  final String localPath;

  @HiveField(4)
  String? remoteUrl;

  @HiveField(10)
  String? thumbnailUrl;

  @HiveField(5)
  final double? latitude;

  @HiveField(6)
  final double? longitude;

  @HiveField(7)
  String? annotation;

  @HiveField(8)
  final DateTime capturedAt;

  @HiveField(9)
  bool isSynced;

  PhotoModel({
    required this.id,
    required this.jobId,
    required this.stepId,
    required this.localPath,
    this.remoteUrl,
    this.thumbnailUrl,
    this.latitude,
    this.longitude,
    this.annotation,
    required this.capturedAt,
    this.isSynced = false,
  });

  PhotoEntity toEntity() {
    return PhotoEntity(
      id: id,
      jobId: jobId,
      stepId: stepId,
      localPath: localPath,
      remoteUrl: remoteUrl,
      thumbnailUrl: thumbnailUrl,
      latitude: latitude,
      longitude: longitude,
      annotation: annotation,
      capturedAt: capturedAt,
      isSynced: isSynced,
    );
  }

  factory PhotoModel.fromEntity(PhotoEntity entity) {
    return PhotoModel(
      id: entity.id,
      jobId: entity.jobId,
      stepId: entity.stepId,
      localPath: entity.localPath,
      remoteUrl: entity.remoteUrl,
      thumbnailUrl: entity.thumbnailUrl,
      latitude: entity.latitude,
      longitude: entity.longitude,
      annotation: entity.annotation,
      capturedAt: entity.capturedAt,
      isSynced: entity.isSynced,
    );
  }
}
