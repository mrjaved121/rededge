import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/job_model.dart';
import '../models/step_model.dart';

class JobRemoteDataSource {
  final ApiClient _api;

  const JobRemoteDataSource(this._api);

  Future<List<JobModel>> fetchJobs({String? status, String? system}) async {
    try {
      final response = await _api.getJobs(status: status, system: system);
      final list = response.data['data'] as List;
      return list.map((json) => JobModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<({JobModel job, List<StepModel> steps})> fetchJobDetail(
      String jobId,
      ) async {
    try {
      final response = await _api.getJobDetail(jobId);
      final data = response.data['data'] as Map<String, dynamic>;
      final job = JobModel.fromJson(data);
      final steps = (data['steps'] as List? ?? [])
          .map((s) => StepModel.fromJson(s, jobId))
          .toList();
      return (job: job, steps: steps);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<JobModel> createJob(Map<String, dynamic> data) async {
    try {
      final response = await _api.createJob(data);
      return JobModel.fromJson(response.data['data']);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> completeStep(
      String jobId,
      String stepId,
      Map<String, dynamic> data,
      ) async {
    try {
      await _api.completeStep(jobId, stepId, data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}