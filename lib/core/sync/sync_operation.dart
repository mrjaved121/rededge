import 'package:hive/hive.dart';


@HiveType(typeId: 10)
class SyncOperation extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type; // 'upload_photo' | 'complete_step' | 'add_note' | 'create_job'

  @HiveField(2)
  final Map<String, dynamic> payload;

  @HiveField(3)
  int retryCount;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  DateTime? lastAttempt;

  @HiveField(6)
  String status; // 'pending' | 'in_progress' | 'done' | 'failed'

  @HiveField(7)
  String? errorMessage;

  SyncOperation({
    required this.id,
    required this.type,
    required this.payload,
    this.retryCount = 0,
    required this.createdAt,
    this.lastAttempt,
    this.status = 'pending',
    this.errorMessage,
  });

  bool get canRetry => retryCount < 5;
  bool get isPending => status == 'pending' || status == 'failed';

  Duration get nextRetryDelay {
    // Exponential backoff: 2^retryCount seconds
    final seconds = 1 << retryCount; // 1, 2, 4, 8, 16
    return Duration(seconds: seconds);
  }
}