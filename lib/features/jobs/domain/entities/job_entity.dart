import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/step_entity.dart';

class JobEntity {
  final String id;
  final String jobNumber;
  final String title;
  final JobStatus status;
  final String systemType;
  final String location;
  final String address;
  final DateTime date;
  final int completedSteps;
  final int totalSteps;
  final List<StepEntity> steps;
  final String company;
  final bool isSynced;
  final String? assignedToId;
  final String? assignedToName;
  final String? description;

  const JobEntity({
    required this.id,
    this.jobNumber = '',
    required this.title,
    required this.status,
    required this.systemType,
    required this.location,
    required this.address,
    required this.date,
    required this.completedSteps,
    required this.totalSteps,
    this.steps = const [],
    required this.company,
    this.isSynced = true,
    this.assignedToId,
    this.assignedToName,
    this.description,
  });

  bool get isComplete => completedSteps == totalSteps && totalSteps > 0;

  double get progressPercent =>
      totalSteps > 0 ? completedSteps / totalSteps : 0.0;

  String get displayId => jobNumber.isNotEmpty ? jobNumber : id;

  String get formattedDate {
    final d = date;
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }

  JobEntity copyWith({
    String? id,
    String? jobNumber,
    String? title,
    JobStatus? status,
    String? systemType,
    String? location,
    String? address,
    DateTime? date,
    int? completedSteps,
    int? totalSteps,
    List<StepEntity>? steps,
    String? company,
    bool? isSynced,
    String? assignedToId,
    String? assignedToName,
    String? description,
  }) {
    return JobEntity(
      id: id ?? this.id,
      jobNumber: jobNumber ?? this.jobNumber,
      title: title ?? this.title,
      status: status ?? this.status,
      systemType: systemType ?? this.systemType,
      location: location ?? this.location,
      address: address ?? this.address,
      date: date ?? this.date,
      completedSteps: completedSteps ?? this.completedSteps,
      totalSteps: totalSteps ?? this.totalSteps,
      steps: steps ?? this.steps,
      company: company ?? this.company,
      isSynced: isSynced ?? this.isSynced,
      assignedToId: assignedToId ?? this.assignedToId,
      assignedToName: assignedToName ?? this.assignedToName,
      description: description ?? this.description,
    );
  }
}
