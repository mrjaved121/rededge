import 'dart:async';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';
import '../storage/hive_service.dart';

enum SyncStatus {
  idle,
  syncing,
  error,
}

class SyncState {
  final SyncStatus status;
  final int pendingCount;
  final int failedCount;
  final DateTime? lastSyncAt;
  final String? errorMessage;

  const SyncState({
    this.status = SyncStatus.idle,
    this.pendingCount = 0,
    this.failedCount = 0,
    this.lastSyncAt,
    this.errorMessage,
  });

  SyncState copyWith({
    SyncStatus? status,
    int? pendingCount,
    int? failedCount,
    DateTime? lastSyncAt,
    String? errorMessage,
  }) {
    return SyncState(
      status: status ?? this.status,
      pendingCount: pendingCount ?? this.pendingCount,
      failedCount: failedCount ?? this.failedCount,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Sync queue uses raw Maps stored in Hive – no type adapters required.
class SyncManager {
  final ApiClient _api;
  final NetworkInfo _networkInfo;
  final Box _syncBox;
  final _uuid = const Uuid();

  final _stateController = StreamController<SyncState>.broadcast();
  Stream<SyncState> get stateStream => _stateController.stream;

  SyncState _currentState = const SyncState();
  SyncState get currentState => _currentState;

  bool _isFlushing = false;

  SyncManager({
    required ApiClient api,
    required NetworkInfo networkInfo,
  })  : _api = api,
        _networkInfo = networkInfo,
        _syncBox = HiveService.getBox(HiveService.syncQueueBox);

  // ── Enqueue ───────────────────────────────────────────
  Future<void> enqueue({
    required String type,
    required Map<String, dynamic> payload,
  }) async {
    final id = _uuid.v4();
    await _syncBox.put(id, {
      'id': id,
      'type': type,
      'payload': Map<String, dynamic>.from(payload),
      'retryCount': 0,
      'createdAt': DateTime.now().toIso8601String(),
      'status': 'pending',
    });
    _updateState();

    // Attempt immediate flush if online
    if (await _networkInfo.isConnected) {
      flush();
    }
  }

  // ── Flush Queue ───────────────────────────────────────
  Future<void> flush() async {
    if (_isFlushing) return;
    if (!await _networkInfo.isConnected) return;

    _isFlushing = true;
    _emitState(status: SyncStatus.syncing);

    final keys = _syncBox.keys.toList();
    for (final key in keys) {
      final raw = _syncBox.get(key);
      // Clean up any legacy SyncOperation objects that can't be cast
      if (raw is! Map) {
        await _syncBox.delete(key);
        continue;
      }
      final op = Map<String, dynamic>.from(raw);
      final status = op['status'] as String? ?? 'pending';
      if (status != 'pending' && status != 'failed') continue;
      final retryCount = (op['retryCount'] as num? ?? 0).toInt();
      if (retryCount >= 5) continue;

      try {
        op['status'] = 'in_progress';
        await _syncBox.put(key, op);

        final payload = op['payload'];
        await _executeOperation(
          op['type'] as String,
          payload is Map
              ? Map<String, dynamic>.from(payload)
              : <String, dynamic>{},
        );

        await _syncBox.delete(key);
      } catch (e) {
        op['status'] = 'failed';
        op['retryCount'] = retryCount + 1;
        op['errorMessage'] = e.toString();
        await _syncBox.put(key, op);
      }
    }

    _isFlushing = false;
    _emitState(
      status: SyncStatus.idle,
      lastSyncAt: DateTime.now(),
    );
    _updateState();
    _cleanupCompleted();
  }

  Future<void> _executeOperation(
      String type, Map<String, dynamic> payload) async {
    switch (type) {
      case 'upload_photo':
        final filePath = payload['localPath'] as String;
        final metadata = Map<String, dynamic>.from(payload)
          ..remove('localPath');
        await _api.uploadPhoto(filePath, metadata);
        break;

      case 'complete_step':
        await _api.completeStep(
          payload['jobId'] as String,
          payload['stepId'] as String,
          {
            'completed': payload['completed'],
            'notes': payload['notes'],
          },
        );
        break;

      case 'create_job':
        await _api.createJob(payload);
        break;

      case 'add_note':
        await _api.completeStep(
          payload['jobId'] as String,
          payload['stepId'] as String,
          {'notes': payload['notes']},
        );
        break;

      default:
        throw UnsupportedError('Unknown sync operation type: $type');
    }
  }

  void _cleanupCompleted() {
    final cutoff = DateTime.now().subtract(const Duration(hours: 24));
    final toRemove = <dynamic>[];
    for (final key in _syncBox.keys) {
      final raw = _syncBox.get(key);
      if (raw is! Map) {
        toRemove.add(key);
        continue;
      }
      final op = Map<String, dynamic>.from(raw);
      if (op['status'] == 'done') {
        final created = DateTime.tryParse(op['createdAt'] as String? ?? '');
        if (created != null && created.isBefore(cutoff)) toRemove.add(key);
      }
    }
    for (final key in toRemove) {
      _syncBox.delete(key);
    }
  }

  void _updateState() {
    int pending = 0;
    int failed = 0;
    for (final key in _syncBox.keys) {
      final raw = _syncBox.get(key);
      if (raw is! Map) continue;
      final status = raw['status'] as String? ?? '';
      final retryCount = ((raw)['retryCount'] as num? ?? 0).toInt();
      if (status == 'pending') pending++;
      if (status == 'failed' && retryCount >= 5) failed++;
    }
    _emitState(pendingCount: pending, failedCount: failed);
  }

  void _emitState({
    SyncStatus? status,
    int? pendingCount,
    int? failedCount,
    DateTime? lastSyncAt,
    String? errorMessage,
  }) {
    _currentState = _currentState.copyWith(
      status: status,
      pendingCount: pendingCount,
      failedCount: failedCount,
      lastSyncAt: lastSyncAt,
      errorMessage: errorMessage,
    );
    _stateController.add(_currentState);
  }

  void dispose() {
    _stateController.close();
  }
}