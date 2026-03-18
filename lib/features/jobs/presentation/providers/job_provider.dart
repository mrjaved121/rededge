import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:red_edge_app/core/widgets/status_badge.dart';
import 'package:red_edge_app/di/injection.dart';
import 'package:red_edge_app/features/jobs/domain/entities/job_entity.dart';
import 'package:red_edge_app/features/jobs/domain/repositories/job_repository.dart';
import 'package:red_edge_app/features/jobs/domain/usecases/get_jobs_usecase.dart';

// ── Filter state ────────────────────────────────────────
final statusFilterProvider = StateProvider<JobStatus?>((ref) => null);
final systemFilterProvider = StateProvider<String?>((ref) => null);

// ── Jobs list provider ──────────────────────────────────
final jobsNotifierProvider =
    AsyncNotifierProvider<JobsNotifier, List<JobEntity>>(
  () => JobsNotifier(),
);

class JobsNotifier extends AsyncNotifier<List<JobEntity>> {
  @override
  Future<List<JobEntity>> build() async {
    final statusFilter = ref.watch(statusFilterProvider);
    final systemFilter = ref.watch(systemFilterProvider);

    final result = await getIt<GetJobsUseCase>()(
      statusFilter: statusFilter,
      systemFilter: systemFilter,
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (jobs) => jobs,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

// ── Convenience: watch filtered jobs with auto-rebuild ──
final filteredJobsProvider = Provider<AsyncValue<List<JobEntity>>>((ref) {
  return ref.watch(jobsNotifierProvider);
});

// ── Single job detail ───────────────────────────────────
final jobDetailProvider =
    FutureProvider.family<JobEntity, String>((ref, jobId) async {
  final result = await getIt<JobRepository>().getJobDetail(jobId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (job) => job,
  );
});
