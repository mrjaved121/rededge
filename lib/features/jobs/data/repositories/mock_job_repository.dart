// import 'package:fpdart/fpdart.dart';
// import 'package:red_edge_app/core/error/failures.dart';
// import 'package:red_edge_app/core/widgets/status_badge.dart';
// import 'package:red_edge_app/core/widgets/system_chip.dart';
// import 'package:red_edge_app/features/jobs/domain/entities/job_entity.dart';
// import 'package:red_edge_app/features/jobs/domain/entities/step_entity.dart';
// import 'package:red_edge_app/features/jobs/domain/repositories/job_repository.dart';

// class MockJobRepository implements JobRepository {
//   // ── Fake job data ─────────────────────────────────────
//   final List<JobEntity> _mockJobs = [
//     JobEntity(
//       id: 'JOB-001',
//       title: 'Hemisphere VR-1000 Dozer Installation',
//       status: JobStatus.inProgress,
//       systemType: SystemType.hemisphereVR1000Dozer,
//       location: 'Brisbane QLD',
//       address: '45 Mining Road, Mount Isa QLD 4825',
//       date: DateTime(2026, 3, 15),
//       completedSteps: 3,
//       totalSteps: 8,
//       company: 'BHP Mining Corp',
//       steps: _generateSteps('JOB-001', 8, 3),
//     ),
//     JobEntity(
//       id: 'JOB-002',
//       title: 'Topcon MC-3 Excavator Setup',
//       status: JobStatus.pending,
//       systemType: SystemType.topconMC3,
//       location: 'Sydney NSW',
//       address: '12 Construction Ave, Parramatta NSW 2150',
//       date: DateTime(2026, 3, 18),
//       completedSteps: 0,
//       totalSteps: 6,
//       company: 'Lendlease Infrastructure',
//       steps: _generateSteps('JOB-002', 6, 0),
//     ),
//     JobEntity(
//       id: 'JOB-003',
//       title: 'Leica iMC Bulldozer Retrofit',
//       status: JobStatus.completed,
//       systemType: SystemType.leicaIMC,
//       location: 'Perth WA',
//       address: '88 Hay Street, Perth WA 6000',
//       date: DateTime(2026, 3, 10),
//       completedSteps: 5,
//       totalSteps: 5,
//       company: 'Rio Tinto Operations',
//       steps: _generateSteps('JOB-003', 5, 5),
//     ),
//     JobEntity(
//       id: 'JOB-004',
//       title: 'Stonex STX-Dig Grader Install',
//       status: JobStatus.draft,
//       systemType: SystemType.stonexSTXDig,
//       location: 'Melbourne VIC',
//       address: '200 Collins Street, Melbourne VIC 3000',
//       date: DateTime(2026, 3, 22),
//       completedSteps: 0,
//       totalSteps: 7,
//       company: 'CIMIC Group',
//       steps: _generateSteps('JOB-004', 7, 0),
//     ),
//     JobEntity(
//       id: 'JOB-005',
//       title: 'Trimble SiteVision Paver Setup',
//       status: JobStatus.inProgress,
//       systemType: SystemType.trimbleSiteVision,
//       location: 'Adelaide SA',
//       address: '55 King William St, Adelaide SA 5000',
//       date: DateTime(2026, 3, 20),
//       completedSteps: 2,
//       totalSteps: 6,
//       company: 'Fulton Hogan',
//       steps: _generateSteps('JOB-005', 6, 2),
//     ),
//   ];

//   static List<StepEntity> _generateSteps(
//       String jobId,
//       int total,
//       int completed,
//       ) {
//     final stepTemplates = [
//       'Pre-Installation Safety Check',
//       'Mount GNSS Antenna',
//       'Install Control Box',
//       'Wire Hydraulic Sensors',
//       'Configure Base Station',
//       'Calibrate Machine Geometry',
//       'Run System Diagnostics',
//       'Final Sign-Off & Handover',
//     ];

//     return List.generate(total, (i) {
//       return StepEntity(
//         id: '$jobId-step-${i + 1}',
//         number: i + 1,
//         title: stepTemplates[i % stepTemplates.length],
//         description: 'Complete step ${i + 1} of the installation process.',
//         requiresPhoto: i % 2 == 0, // Every other step requires photo
//         isCompleted: i < completed,
//         photos: const [],
//         notes: i < completed ? 'Completed successfully' : null,
//       );
//     });
//   }

//   // ── Track completed steps locally ─────────────────────
//   final Map<String, bool> _completedSteps = {};

//   @override
//   Future<Either<Failure, List<JobEntity>>> getJobs({
//     JobStatus? statusFilter,
//     SystemType? systemFilter,
//   }) async {
//     // Simulate network delay
//     await Future.delayed(const Duration(milliseconds: 500));

//     var result = List<JobEntity>.from(_mockJobs);

//     if (statusFilter != null) {
//       result = result.where((j) => j.status == statusFilter).toList();
//     }
//     if (systemFilter != null) {
//       result = result.where((j) => j.systemType == systemFilter).toList();
//     }

//     result.sort((a, b) => b.date.compareTo(a.date));
//     return Right(result);
//   }

//   @override
//   Future<Either<Failure, JobEntity>> getJobDetail(String jobId) async {
//     await Future.delayed(const Duration(milliseconds: 300));

//     try {
//       final job = _mockJobs.firstWhere((j) => j.id == jobId);

//       // Apply any local step completions
//       final updatedSteps = job.steps.map((step) {
//         final isCompleted =
//             _completedSteps[step.id] ?? step.isCompleted;
//         return step.copyWith(isCompleted: isCompleted);
//       }).toList();

//       final completedCount =
//           updatedSteps.where((s) => s.isCompleted).length;

//       return Right(job.copyWith(
//         steps: updatedSteps,
//         completedSteps: completedCount,
//       ));
//     } catch (_) {
//       return const Left(CacheFailure('Job not found'));
//     }
//   }

//   @override
//   Future<Either<Failure, JobEntity>> createJob(
//       Map<String, dynamic> data,
//       ) async {
//     await Future.delayed(const Duration(milliseconds: 500));

//     final newJob = JobEntity(
//       id: 'JOB-${_mockJobs.length + 1}'.padLeft(3, '0'),
//       title: data['title'] ?? 'New Installation',
//       status: JobStatus.draft,
//       systemType: SystemType.other,
//       location: data['location'] ?? 'TBD',
//       address: data['address'] ?? '',
//       date: DateTime.now(),
//       completedSteps: 0,
//       totalSteps: 5,
//       company: data['company'] ?? 'Unknown',
//       steps: _generateSteps(
//         'JOB-${_mockJobs.length + 1}'.padLeft(3, '0'),
//         5,
//         0,
//       ),
//     );

//     _mockJobs.add(newJob);
//     return Right(newJob);
//   }

//   @override
//   Future<Either<Failure, void>> completeStep(
//       String jobId,
//       String stepId, {
//         String? notes,
//       }) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     _completedSteps[stepId] = true;
//     return const Right(null);
//   }

//   @override
//   Future<Either<Failure, void>> addNotes(
//       String jobId,
//       String stepId,
//       String notes,
//       ) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     return const Right(null);
//   }
// }