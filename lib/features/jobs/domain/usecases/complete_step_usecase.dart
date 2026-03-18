import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/job_repository.dart';

class CompleteStepUseCase {
  final JobRepository _repository;

  const CompleteStepUseCase(this._repository);

  Future<Either<Failure, void>> call(
      String jobId,
      String stepId, {
        String? notes,
      }) {
    return _repository.completeStep(jobId, stepId, notes: notes);
  }
}