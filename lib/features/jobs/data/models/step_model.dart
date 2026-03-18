import 'package:hive/hive.dart';
import 'package:red_edge_app/features/jobs/domain/entities/photo_entity.dart';
import '../../domain/entities/step_entity.dart';


@HiveType(typeId: 1)
class StepModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String jobId;

  @HiveField(2)
  final int number;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final bool requiresPhoto;

  @HiveField(6)
  bool isCompleted;

  @HiveField(7)
  String? notes;

  @HiveField(8)
  int photoCount;

  StepModel({
    required this.id,
    required this.jobId,
    required this.number,
    required this.title,
    this.description,
    this.requiresPhoto = false,
    this.isCompleted = false,
    this.notes,
    this.photoCount = 0,
  });

  factory StepModel.fromJson(Map<String, dynamic> json, String jobId) {
    return StepModel(
      id: json['id'] as String,
      jobId: jobId,
      number: json['number'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      requiresPhoto: json['requiresPhoto'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      notes: json['notes'] as String?,
      photoCount: (json['photos'] as List?)?.length ?? 0,
    );
  }

  StepEntity toEntity({List<PhotoEntity> photos = const []}) {
    return StepEntity(
      id: id,
      number: number,
      title: title,
      description: description,
      requiresPhoto: requiresPhoto,
      isCompleted: isCompleted,
      photos: photos,
      notes: notes,
    );
  }

  factory StepModel.fromEntity(StepEntity entity, String jobId) {
    return StepModel(
      id: entity.id,
      jobId: jobId,
      number: entity.number,
      title: entity.title,
      description: entity.description,
      requiresPhoto: entity.requiresPhoto,
      isCompleted: entity.isCompleted,
      notes: entity.notes,
      photoCount: entity.photoCount,
    );
  }
}