import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/widgets/status_badge.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

class GetJobsUseCase {
  final JobRepository _repository;

  const GetJobsUseCase(this._repository);

  Future<Either<Failure, List<JobEntity>>> call({
    JobStatus? statusFilter,
    String? systemFilter,
  }) {
    return _repository.getJobs(
      statusFilter: statusFilter,
      systemFilter: systemFilter,
    );
  }
}
