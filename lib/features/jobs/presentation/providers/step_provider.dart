import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:red_edge_app/di/injection.dart';
import 'package:red_edge_app/features/jobs/presentation/providers/job_provider.dart';
import '../../domain/usecases/complete_step_usecase.dart';


class StepActionNotifier extends StateNotifier<AsyncValue<void>> {
  final CompleteStepUseCase _completeStepUseCase;
  final Ref _ref;

  StepActionNotifier(this._completeStepUseCase, this._ref)
      : super(const AsyncValue.data(null));

  Future<void> completeStep(
      String jobId,
      String stepId, {
        String? notes,
      }) async {
    state = const AsyncValue.loading();

    final result = await _completeStepUseCase(jobId, stepId, notes: notes);

    result.fold(
          (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
          (_) {
        state = const AsyncValue.data(null);
        // Refresh job detail to reflect new completion state
        _ref.invalidate(jobDetailProvider(jobId));
      },
    );
  }
}

final stepActionProvider =
StateNotifierProvider<StepActionNotifier, AsyncValue<void>>((ref) {
  return StepActionNotifier(
    getIt<CompleteStepUseCase>(),
    ref,
  );
});