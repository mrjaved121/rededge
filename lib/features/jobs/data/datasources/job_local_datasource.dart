import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/hive_service.dart';
import '../models/job_model.dart';
import '../models/step_model.dart';

class JobLocalDataSource {
  Box get _jobsBox => HiveService.getBox(HiveService.jobsBox);
  Box get _stepsBox => HiveService.getBox(HiveService.stepsBox);

  // ── Jobs ──────────────────────────────────────────────
  Future<List<JobModel>> getCachedJobs() async {
    try {
      return _jobsBox.values.cast<JobModel>().toList();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<JobModel?> getCachedJob(String jobId) async {
    try {
      return _jobsBox.get(jobId) as JobModel?;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> cacheJobs(List<JobModel> jobs) async {
    try {
      final map = {for (final j in jobs) j.id: j};
      await _jobsBox.putAll(map);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> cacheJob(JobModel job) async {
    try {
      await _jobsBox.put(job.id, job);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  // ── Steps ─────────────────────────────────────────────
  Future<List<StepModel>> getCachedSteps(String jobId) async {
    try {
      return _stepsBox.values
          .cast<StepModel>()
          .where((s) => s.jobId == jobId)
          .toList()
        ..sort((a, b) => a.number.compareTo(b.number));
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> cacheSteps(List<StepModel> steps) async {
    try {
      final map = {for (final s in steps) s.id: s};
      await _stepsBox.putAll(map);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> markStepCompleted(
      String stepId, {
        String? notes,
      }) async {
    try {
      final step = _stepsBox.get(stepId) as StepModel?;
      if (step != null) {
        step.isCompleted = true;
        if (notes != null) step.notes = notes;
        await _stepsBox.put(stepId, step);
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> updateCompletedCount(String jobId) async {
    try {
      final steps = await getCachedSteps(jobId);
      final completed = steps.where((s) => s.isCompleted).length;
      final job = _jobsBox.get(jobId) as JobModel?;
      if (job != null) {
        final updated = JobModel(
          id: job.id,
          title: job.title,
          status: completed == steps.length ? 'completed' : job.status,
          systemType: job.systemType,
          location: job.location,
          address: job.address,
          date: job.date,
          completedSteps: completed,
          totalSteps: job.totalSteps,
          company: job.company,
          isSynced: false,
        );
        await _jobsBox.put(jobId, updated);
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}