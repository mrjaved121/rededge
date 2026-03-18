import 'package:red_edge_app/features/jobs/domain/entities/photo_entity.dart';


class StepEntity {
  final String id;
  final int number;
  final String title;
  final String? description;
  final bool requiresPhoto;
  final bool isCompleted;
  final List<PhotoEntity> photos;
  final String? notes;

  const StepEntity({
    required this.id,
    required this.number,
    required this.title,
    this.description,
    this.requiresPhoto = false,
    this.isCompleted = false,
    this.photos = const [],
    this.notes,
  });

  bool get hasPhoto => photos.isNotEmpty;
  int get photoCount => photos.length;
  bool get needsPhoto => requiresPhoto && !hasPhoto;

  StepEntity copyWith({
    String? id,
    int? number,
    String? title,
    String? description,
    bool? requiresPhoto,
    bool? isCompleted,
    List<PhotoEntity>? photos,
    String? notes,
  }) {
    return StepEntity(
      id: id ?? this.id,
      number: number ?? this.number,
      title: title ?? this.title,
      description: description ?? this.description,
      requiresPhoto: requiresPhoto ?? this.requiresPhoto,
      isCompleted: isCompleted ?? this.isCompleted,
      photos: photos ?? this.photos,
      notes: notes ?? this.notes,
    );
  }
}