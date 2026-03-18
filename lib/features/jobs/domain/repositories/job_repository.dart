import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/widgets/status_badge.dart';
import '../entities/job_entity.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> getJobs({
    JobStatus? statusFilter,
    String? systemFilter,
  });

  Future<Either<Failure, JobEntity>> getJobDetail(String jobId);

  Future<Either<Failure, JobEntity>> createJob(Map<String, dynamic> data);

  Future<Either<Failure, JobEntity>> updateJob(
      String jobId, Map<String, dynamic> data);

  Future<Either<Failure, void>> deleteJob(String jobId);

  Future<Either<Failure, JobEntity>> updateJobStatus(
      String jobId, String status);

  Future<Either<Failure, void>> completeStep(
    String jobId,
    String stepId, {
    String? notes,
  });

  Future<Either<Failure, void>> addNotes(
    String jobId,
    String stepId,
    String notes,
  );
}
