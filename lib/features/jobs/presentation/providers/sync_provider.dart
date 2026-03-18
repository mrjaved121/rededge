import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:red_edge_app/di/injection.dart';
import '../../../../core/sync/sync_manager.dart';

final syncStatusProvider = StreamProvider<SyncState>((ref) {
  return getIt<SyncManager>().stateStream;
});

final syncManagerProvider = Provider<SyncManager>((ref) {
  return getIt<SyncManager>();
});