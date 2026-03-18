import 'package:hive/hive.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/entities/step_entity.dart';

@HiveType(typeId: 0)
class JobModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String systemType;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String address;

  @HiveField(6)
  final DateTime date;

  @HiveField(7)
  final int completedSteps;

  @HiveField(8)
  final int totalSteps;

  @HiveField(9)
  final String company;

  @HiveField(10)
  final bool isSynced;

  JobModel({
    required this.id,
    required this.title,
    required this.status,
    required this.systemType,
    required this.location,
    required this.address,
    required this.date,
    required this.completedSteps,
    required this.totalSteps,
    required this.company,
    this.isSynced = true,
  });

  // JSON → Model
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      systemType: json['systemType'] as String,
      location: json['location'] as String,
      address: json['address'] as String? ?? '',
      date: DateTime.parse(json['date'] as String),
      completedSteps: json['completedSteps'] as int? ?? 0,
      totalSteps: json['totalSteps'] as int? ?? 0,
      company: json['company'] as String? ?? '',
      isSynced: true,
    );
  }

  // Model → JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'status': status,
        'systemType': systemType,
        'location': location,
        'address': address,
        'date': date.toIso8601String(),
        'completedSteps': completedSteps,
        'totalSteps': totalSteps,
        'company': company,
      };

  // Model → Entity
  JobEntity toEntity({List<StepEntity> steps = const []}) {
    return JobEntity(
      id: id,
      title: title,
      status: _parseStatus(status),
      systemType: systemType,
      location: location,
      address: address,
      date: date,
      completedSteps: completedSteps,
      totalSteps: totalSteps,
      steps: steps,
      company: company,
      isSynced: isSynced,
    );
  }

  // Entity → Model
  factory JobModel.fromEntity(JobEntity entity) {
    return JobModel(
      id: entity.id,
      title: entity.title,
      status: entity.status.name,
      systemType: entity.systemType,
      location: entity.location,
      address: entity.address,
      date: entity.date,
      completedSteps: entity.completedSteps,
      totalSteps: entity.totalSteps,
      company: entity.company,
      isSynced: entity.isSynced,
    );
  }

  static JobStatus _parseStatus(String s) => switch (s) {
        'draft' => JobStatus.draft,
        'pending' => JobStatus.pending,
        'inProgress' || 'in_progress' => JobStatus.inProgress,
        'completed' => JobStatus.completed,
        _ => JobStatus.pending,
      };
}
