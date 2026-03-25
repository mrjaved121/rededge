// /// Mock repositories for offline UI testing — no backend needed.
// /// Toggle via `useMockData` flag in injection.dart.
// library;
//
// import 'package:fpdart/fpdart.dart';
// import 'package:uuid/uuid.dart';
//
// import '../core/error/failures.dart';
// import '../core/widgets/status_badge.dart';
// import '../features/auth/domain/entities/user_entity.dart';
// import '../features/auth/domain/repositories/auth_repository.dart';
// import '../features/jobs/domain/entities/job_entity.dart';
// import '../features/jobs/domain/entities/photo_entity.dart';
// import '../features/jobs/domain/entities/step_entity.dart';
// import '../features/jobs/domain/repositories/job_repository.dart';
// import '../features/photos/domain/repositories/photo_repository.dart';
//
// // ─────────────────────────────────────────────────────────
// // Shared in-memory data store (lives as long as the app runs)
// // ─────────────────────────────────────────────────────────
//
// const _uuid = Uuid();
//
// // ── Users ────────────────────────────────────────────────
// final UserEntity _adminUser = const UserEntity(
//   id: 'admin-001',
//   name: 'Admin User',
//   email: 'admin@rededge.com',
//   role: 'admin',
//   phone: '0400000000',
// );
//
// final UserEntity _mikeInstaller = const UserEntity(
//   id: 'inst-001',
//   name: 'Mike Johnson',
//   email: 'mike@rededge.com',
//   role: 'installer',
//   phone: '0411111111',
// );
//
// final UserEntity _tomInstaller = const UserEntity(
//   id: 'inst-002',
//   name: 'Tom Wilson',
//   email: 'tom@rededge.com',
//   role: 'installer',
//   phone: '0422222222',
// );
//
// final UserEntity _lisaInstaller = const UserEntity(
//   id: 'inst-003',
//   name: 'Lisa Chen',
//   email: 'lisa@rededge.com',
//   role: 'installer',
//   phone: '0433333333',
// );
//
// final List<UserEntity> _allUsers = [
//   _adminUser,
//   _mikeInstaller,
//   _tomInstaller,
//   _lisaInstaller,
// ];
//
// // Helper to quickly find the logged-in user by email
// UserEntity? _currentUser;
//
// // ── Steps templates ──────────────────────────────────────
//
// List<StepEntity> _hemisphereDozerSteps() => const [
//       StepEntity(
//           id: '0',
//           number: 1,
//           title: 'Pre-Installation Safety Check',
//           description:
//               'Verify site safety, check PPE, confirm machine isolation',
//           requiresPhoto: true),
//       StepEntity(
//           id: '1',
//           number: 2,
//           title: 'Mount GNSS Antenna on Dozer Blade',
//           description:
//               'Install antenna mount bracket, attach GNSS antenna, route cables',
//           requiresPhoto: true),
//       StepEntity(
//           id: '2',
//           number: 3,
//           title: 'Install VR1000 Control Box in Cabin',
//           description:
//               'Mount control box, connect power supply, verify display',
//           requiresPhoto: true),
//       StepEntity(
//           id: '3',
//           number: 4,
//           title: 'Connect Blade Sensors',
//           description: 'Install blade slope sensor, connect wiring harness',
//           requiresPhoto: true),
//       StepEntity(
//           id: '4',
//           number: 5,
//           title: 'Configure Base Station Link',
//           description: 'Set up radio link or NTRIP connection to base station'),
//       StepEntity(
//           id: '5',
//           number: 6,
//           title: 'Calibrate Machine Geometry',
//           description:
//               'Input dozer dimensions, calibrate blade position sensors'),
//       StepEntity(
//           id: '6',
//           number: 7,
//           title: 'Run System Diagnostics',
//           description:
//               'Run built-in diagnostics, verify GPS fix, test blade control',
//           requiresPhoto: true),
//       StepEntity(
//           id: '7',
//           number: 8,
//           title: 'Field Test & Operator Training',
//           description: 'Perform field test cuts, train operator on system use',
//           requiresPhoto: true),
//       StepEntity(
//           id: '8',
//           number: 9,
//           title: 'Final Sign-Off & Documentation',
//           description:
//               'Complete paperwork, take final photos, get client sign-off',
//           requiresPhoto: true),
//     ];
//
// List<StepEntity> _hemisphereExcavatorSteps() => const [
//       StepEntity(
//           id: '0',
//           number: 1,
//           title: 'Pre-Installation Safety Check',
//           description:
//               'Verify site safety, check PPE, confirm machine isolation',
//           requiresPhoto: true),
//       StepEntity(
//           id: '1',
//           number: 2,
//           title: 'Mount GNSS Antenna on Excavator',
//           description:
//               'Install antenna on cab roof or counterweight, route cables',
//           requiresPhoto: true),
//       StepEntity(
//           id: '2',
//           number: 3,
//           title: 'Install VR1000 Control Box',
//           description: 'Mount control box inside cab, connect power',
//           requiresPhoto: true),
//       StepEntity(
//           id: '3',
//           number: 4,
//           title: 'Install Boom & Stick Sensors',
//           description: 'Mount angle sensors on boom, stick, and bucket pins',
//           requiresPhoto: true),
//       StepEntity(
//           id: '4',
//           number: 5,
//           title: 'Install Bucket Sensor',
//           description: 'Mount tilt sensor on bucket linkage, calibrate',
//           requiresPhoto: true),
//       StepEntity(
//           id: '5',
//           number: 6,
//           title: 'Configure Base Station Link',
//           description: 'Set up radio link or NTRIP connection'),
//       StepEntity(
//           id: '6',
//           number: 7,
//           title: 'Calibrate Machine Geometry',
//           description: 'Input boom/stick/bucket dimensions, calibrate sensors'),
//       StepEntity(
//           id: '7',
//           number: 8,
//           title: 'Run System Diagnostics',
//           description:
//               'Verify GPS fix, test dig guidance, check sensor accuracy',
//           requiresPhoto: true),
//       StepEntity(
//           id: '8',
//           number: 9,
//           title: 'Field Test & Operator Training',
//           description: 'Perform test dig, train operator',
//           requiresPhoto: true),
//       StepEntity(
//           id: '9',
//           number: 10,
//           title: 'Final Sign-Off & Documentation',
//           description:
//               'Complete paperwork, take final photos, get client sign-off',
//           requiresPhoto: true),
//     ];
//
// List<StepEntity> _stonexDozerSteps() => const [
//       StepEntity(
//           id: '0',
//           number: 1,
//           title: 'Pre-Installation Safety Check',
//           description: 'PPE check, machine isolation, site inspection',
//           requiresPhoto: true),
//       StepEntity(
//           id: '1',
//           number: 2,
//           title: 'Install Stonex GNSS Receiver',
//           description: 'Mount GNSS receiver on dozer, connect cables',
//           requiresPhoto: true),
//       StepEntity(
//           id: '2',
//           number: 3,
//           title: 'Mount STX-DIG Display',
//           description: 'Install display unit in cab, connect power and data',
//           requiresPhoto: true),
//       StepEntity(
//           id: '3',
//           number: 4,
//           title: 'Install Blade Sensors',
//           description: 'Mount blade rotation and slope sensors',
//           requiresPhoto: true),
//       StepEntity(
//           id: '4',
//           number: 5,
//           title: 'Connect Hydraulic Control Valves',
//           description: 'Wire automatic blade control valves',
//           requiresPhoto: true),
//       StepEntity(
//           id: '5',
//           number: 6,
//           title: 'Configure Corrections Source',
//           description: 'Set up NTRIP or local base station'),
//       StepEntity(
//           id: '6',
//           number: 7,
//           title: 'Calibrate Machine Profile',
//           description: 'Input machine dimensions, calibrate sensors'),
//       StepEntity(
//           id: '7',
//           number: 8,
//           title: 'System Test & Validation',
//           description: 'Run diagnostics, verify accuracy',
//           requiresPhoto: true),
//       StepEntity(
//           id: '8',
//           number: 9,
//           title: 'Final Sign-Off',
//           description: 'Paperwork and client handoff',
//           requiresPhoto: true),
//     ];
//
// List<StepEntity> _stonexExcavatorSteps() => const [
//       StepEntity(
//           id: '0',
//           number: 1,
//           title: 'Pre-Installation Safety Check',
//           description: 'PPE check, machine isolation',
//           requiresPhoto: true),
//       StepEntity(
//           id: '1',
//           number: 2,
//           title: 'Install Stonex GNSS Receiver',
//           description: 'Mount on excavator cab',
//           requiresPhoto: true),
//       StepEntity(
//           id: '2',
//           number: 3,
//           title: 'Mount STX-DIG Display',
//           description: 'Install display in cab',
//           requiresPhoto: true),
//       StepEntity(
//           id: '3',
//           number: 4,
//           title: 'Install Boom/Stick Sensors',
//           description: 'Mount angle sensors on boom and stick',
//           requiresPhoto: true),
//       StepEntity(
//           id: '4',
//           number: 5,
//           title: 'Install Bucket Sensor',
//           description: 'Mount tilt sensor on bucket',
//           requiresPhoto: true),
//       StepEntity(
//           id: '5',
//           number: 6,
//           title: 'Configure Corrections Source',
//           description: 'Set up NTRIP or base station'),
//       StepEntity(
//           id: '6',
//           number: 7,
//           title: 'Calibrate Excavator Profile',
//           description: 'Enter arm geometry, calibrate'),
//       StepEntity(
//           id: '7',
//           number: 8,
//           title: 'System Test & Validation',
//           description: 'Run diagnostics',
//           requiresPhoto: true),
//       StepEntity(
//           id: '8',
//           number: 9,
//           title: 'Final Sign-Off',
//           description: 'Paperwork and client handoff',
//           requiresPhoto: true),
//     ];
//
// List<StepEntity> _stepsForSystem(String type) => switch (type) {
//       'Hemisphere VR1000 Dozer' => _hemisphereDozerSteps(),
//       'Hemisphere VR1000 Excavator' => _hemisphereExcavatorSteps(),
//       'Stonex STX-DIG Dozer' => _stonexDozerSteps(),
//       'Stonex STX-DIG Excavator' => _stonexExcavatorSteps(),
//       _ => _hemisphereDozerSteps(),
//     };
//
// // ── Jobs store ───────────────────────────────────────────
//
// final List<JobEntity> _jobs = [
//   JobEntity(
//     id: 'job-001',
//     jobNumber: 'JOB-001',
//     title: 'CAT D6 Dozer - Hemisphere Install',
//     status: JobStatus.inProgress,
//     systemType: 'Hemisphere VR1000 Dozer',
//     location: 'Brisbane QLD',
//     address: '123 Construction Ave, Brisbane QLD 4000',
//     date: DateTime.now().subtract(const Duration(days: 2)),
//     completedSteps: 3,
//     totalSteps: 9,
//     steps: _hemisphereDozerSteps(),
//     company: 'Smith Earthworks',
//     assignedToId: 'inst-001',
//     assignedToName: 'Mike Johnson',
//     description: 'Install Hemisphere VR1000 on CAT D6 dozer for GPS grading',
//   ),
//   JobEntity(
//     id: 'job-002',
//     jobNumber: 'JOB-002',
//     title: 'Komatsu PC200 - Hemisphere Excavator',
//     status: JobStatus.pending,
//     systemType: 'Hemisphere VR1000 Excavator',
//     location: 'Gold Coast QLD',
//     address: '45 Mining Rd, Gold Coast QLD 4217',
//     date: DateTime.now().add(const Duration(days: 1)),
//     completedSteps: 0,
//     totalSteps: 10,
//     steps: _hemisphereExcavatorSteps(),
//     company: 'GC Mining Services',
//     assignedToId: 'inst-001',
//     assignedToName: 'Mike Johnson',
//     description: 'New machine dig guidance system installation',
//   ),
//   JobEntity(
//     id: 'job-003',
//     jobNumber: 'JOB-003',
//     title: 'Volvo EC220E - Stonex STX-DIG',
//     status: JobStatus.completed,
//     systemType: 'Stonex STX-DIG Excavator',
//     location: 'Sydney NSW',
//     address: '78 Builder St, Sydney NSW 2000',
//     date: DateTime.now().subtract(const Duration(days: 5)),
//     completedSteps: 9,
//     totalSteps: 9,
//     steps: _stonexExcavatorSteps(),
//     company: 'Metro Construction',
//     assignedToId: 'inst-002',
//     assignedToName: 'Tom Wilson',
//     description: 'Stonex excavator guidance for tunnel project',
//   ),
//   JobEntity(
//     id: 'job-004',
//     jobNumber: 'JOB-004',
//     title: 'CAT D8 - Stonex Dozer Setup',
//     status: JobStatus.needsApproval,
//     systemType: 'Stonex STX-DIG Dozer',
//     location: 'Melbourne VIC',
//     address: '200 Industrial Blvd, Melbourne VIC 3000',
//     date: DateTime.now().subtract(const Duration(days: 1)),
//     completedSteps: 9,
//     totalSteps: 9,
//     steps: _stonexDozerSteps(),
//     company: 'Pacific Grading Co',
//     assignedToId: 'inst-002',
//     assignedToName: 'Tom Wilson',
//     description: 'Dozer blade control for highway project',
//   ),
//   JobEntity(
//     id: 'job-005',
//     jobNumber: 'JOB-005',
//     title: 'Hitachi ZX350 - Hemisphere Excavator',
//     status: JobStatus.draft,
//     systemType: 'Hemisphere VR1000 Excavator',
//     location: 'Perth WA',
//     address: '500 Outback Rd, Perth WA 6000',
//     date: DateTime.now().add(const Duration(days: 7)),
//     completedSteps: 0,
//     totalSteps: 10,
//     steps: _hemisphereExcavatorSteps(),
//     company: 'WestDig Mining',
//     assignedToId: 'inst-003',
//     assignedToName: 'Lisa Chen',
//     description: 'Mining excavator GPS guidance install',
//   ),
// ];
//
// // ── Photo store ──────────────────────────────────────────
// final List<PhotoEntity> _photos = [];
//
// // ═════════════════════════════════════════════════════════
// // MOCK AUTH REPOSITORY
// // ═════════════════════════════════════════════════════════
//
// class MockAuthRepository implements AuthRepository {
//   @override
//   Future<Either<Failure, ({String token, UserEntity user})>> login(
//     String email,
//     String password,
//   ) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     final user = _allUsers.where((u) => u.email == email).firstOrNull;
//     if (user == null) {
//       return const Left(ServerFailure('Invalid email or password'));
//     }
//     // Accept any password with 6+ chars for testing
//     if (password.length < 6) {
//       return const Left(ServerFailure('Invalid email or password'));
//     }
//     _currentUser = user;
//     return Right((token: 'mock-jwt-token-${user.id}', user: user));
//   }
//
//   @override
//   Future<Either<Failure, ({String token, UserEntity user})>> signup({
//     required String name,
//     required String email,
//     required String password,
//     required String role,
//     String? phone,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     final existing = _allUsers.where((u) => u.email == email).firstOrNull;
//     if (existing != null) {
//       return const Left(ServerFailure('Email already registered'));
//     }
//
//     final newUser = UserEntity(
//       id: 'user-${_uuid.v4().substring(0, 8)}',
//       name: name,
//       email: email,
//       role: role,
//       phone: phone,
//     );
//     _allUsers.add(newUser);
//     _currentUser = newUser;
//     return Right((token: 'mock-jwt-token-${newUser.id}', user: newUser));
//   }
//
//   @override
//   Future<Either<Failure, void>> logout() async {
//     _currentUser = null;
//     return const Right(null);
//   }
//
//   @override
//   Future<Either<Failure, UserEntity>> getCurrentUser() async {
//     if (_currentUser != null) return Right(_currentUser!);
//     return const Left(ServerFailure('Not authenticated'));
//   }
//
//   @override
//   Future<bool> isAuthenticated() async => _currentUser != null;
// }
//
// // ═════════════════════════════════════════════════════════
// // MOCK JOB REPOSITORY
// // ═════════════════════════════════════════════════════════
//
// class MockJobRepository implements JobRepository {
//   @override
//   Future<Either<Failure, List<JobEntity>>> getJobs({
//     JobStatus? statusFilter,
//     String? systemFilter,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     var result = List<JobEntity>.from(_jobs);
//
//     // If current user is installer, only show their jobs
//     if (_currentUser != null && _currentUser!.isInstaller) {
//       result = result.where((j) => j.assignedToId == _currentUser!.id).toList();
//     }
//
//     if (statusFilter != null) {
//       result = result.where((j) => j.status == statusFilter).toList();
//     }
//     if (systemFilter != null) {
//       result = result.where((j) => j.systemType == systemFilter).toList();
//     }
//
//     return Right(result);
//   }
//
//   @override
//   Future<Either<Failure, JobEntity>> getJobDetail(String jobId) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     final job = _jobs.where((j) => j.id == jobId).firstOrNull;
//     if (job == null) return const Left(ServerFailure('Job not found'));
//     return Right(job);
//   }
//
//   @override
//   Future<Either<Failure, JobEntity>> createJob(
//       Map<String, dynamic> data) async {
//     await Future.delayed(const Duration(milliseconds: 400));
//
//     final systemType = data['systemType'] as String? ?? 'Other';
//     final steps = _stepsForSystem(systemType);
//     final jobNum = 'JOB-${(_jobs.length + 1).toString().padLeft(3, '0')}';
//
//     final newJob = JobEntity(
//       id: 'job-${_uuid.v4().substring(0, 8)}',
//       jobNumber: jobNum,
//       title: data['title'] as String? ?? 'New Job',
//       status: JobStatus.draft,
//       systemType: systemType,
//       location: data['location'] as String? ?? '',
//       address: data['address'] as String? ?? '',
//       date: data['scheduledDate'] != null
//           ? DateTime.tryParse(data['scheduledDate'].toString()) ??
//               DateTime.now()
//           : DateTime.now(),
//       completedSteps: 0,
//       totalSteps: steps.length,
//       steps: steps,
//       company: data['company'] as String? ?? '',
//       assignedToId: data['assignedTo'] as String?,
//       assignedToName:
//           _allUsers.where((u) => u.id == data['assignedTo']).firstOrNull?.name,
//       description: data['description'] as String?,
//     );
//
//     _jobs.insert(0, newJob);
//     return Right(newJob);
//   }
//
//   @override
//   Future<Either<Failure, JobEntity>> updateJob(
//       String jobId, Map<String, dynamic> data) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     final idx = _jobs.indexWhere((j) => j.id == jobId);
//     if (idx == -1) return const Left(ServerFailure('Job not found'));
//     final job = _jobs[idx];
//     _jobs[idx] = job.copyWith(
//       title: data['title'] as String? ?? job.title,
//       location: data['location'] as String? ?? job.location,
//       address: data['address'] as String? ?? job.address,
//       company: data['company'] as String? ?? job.company,
//       description: data['description'] as String? ?? job.description,
//     );
//     return Right(_jobs[idx]);
//   }
//
//   @override
//   Future<Either<Failure, void>> deleteJob(String jobId) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     _jobs.removeWhere((j) => j.id == jobId);
//     return const Right(null);
//   }
//
//   @override
//   Future<Either<Failure, JobEntity>> updateJobStatus(
//       String jobId, String status) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     final idx = _jobs.indexWhere((j) => j.id == jobId);
//     if (idx == -1) return const Left(ServerFailure('Job not found'));
//     final job = _jobs[idx];
//     _jobs[idx] = job.copyWith(status: JobStatusX.fromApi(status));
//     return Right(_jobs[idx]);
//   }
//
//   @override
//   Future<Either<Failure, void>> completeStep(
//     String jobId,
//     String stepId, {
//     String? notes,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     final jobIndex = _jobs.indexWhere((j) => j.id == jobId);
//     if (jobIndex == -1) return const Left(ServerFailure('Job not found'));
//
//     final job = _jobs[jobIndex];
//     final stepIdx = int.tryParse(stepId) ?? -1;
//     if (stepIdx < 0 || stepIdx >= job.steps.length) {
//       return const Left(ServerFailure('Step not found'));
//     }
//
//     final updatedSteps = List<StepEntity>.from(job.steps);
//     updatedSteps[stepIdx] = updatedSteps[stepIdx].copyWith(
//       isCompleted: true,
//       notes: notes ?? updatedSteps[stepIdx].notes,
//     );
//
//     final completedCount = updatedSteps.where((s) => s.isCompleted).length;
//     _jobs[jobIndex] = job.copyWith(
//       steps: updatedSteps,
//       completedSteps: completedCount,
//       status: completedCount == updatedSteps.length
//           ? JobStatus.needsApproval
//           : JobStatus.inProgress,
//     );
//
//     return const Right(null);
//   }
//
//   @override
//   Future<Either<Failure, void>> addNotes(
//     String jobId,
//     String stepId,
//     String notes,
//   ) async {
//     await Future.delayed(const Duration(milliseconds: 150));
//
//     final jobIndex = _jobs.indexWhere((j) => j.id == jobId);
//     if (jobIndex == -1) return const Left(ServerFailure('Job not found'));
//
//     final job = _jobs[jobIndex];
//     final stepIdx = int.tryParse(stepId) ?? -1;
//     if (stepIdx < 0 || stepIdx >= job.steps.length) {
//       return const Left(ServerFailure('Step not found'));
//     }
//
//     final updatedSteps = List<StepEntity>.from(job.steps);
//     updatedSteps[stepIdx] = updatedSteps[stepIdx].copyWith(notes: notes);
//     _jobs[jobIndex] = job.copyWith(steps: updatedSteps);
//
//     return const Right(null);
//   }
// }
//
// // ═════════════════════════════════════════════════════════
// // MOCK PHOTO REPOSITORY
// // ═════════════════════════════════════════════════════════
//
// class MockPhotoRepository implements PhotoRepository {
//   @override
//   Future<Either<Failure, PhotoEntity>> savePhoto({
//     required String jobId,
//     required String stepId,
//     required String localPath,
//     double? latitude,
//     double? longitude,
//     String? address,
//     String? annotation,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     final photo = PhotoEntity(
//       id: 'photo-${_uuid.v4().substring(0, 8)}',
//       jobId: jobId,
//       stepId: stepId,
//       localPath: localPath,
//       latitude: latitude ?? -27.4698,
//       longitude: longitude ?? 153.0251,
//       annotation: annotation,
//       capturedAt: DateTime.now(),
//       isSynced: true,
//     );
//     _photos.add(photo);
//     return Right(photo);
//   }
//
//   @override
//   Future<Either<Failure, List<PhotoEntity>>> getPhotosForStep(
//     String jobId,
//     String stepId,
//   ) async {
//     await Future.delayed(const Duration(milliseconds: 100));
//
//     final filtered =
//         _photos.where((p) => p.jobId == jobId && p.stepId == stepId).toList();
//     return Right(filtered);
//   }
//
//   @override
//   Future<Either<Failure, void>> deletePhoto(String photoId) async {
//     _photos.removeWhere((p) => p.id == photoId);
//     return const Right(null);
//   }
// }
//
// // ═════════════════════════════════════════════════════════
// // Helper for admin_provider — mock user lists
// // ═════════════════════════════════════════════════════════
//
// List<UserEntity> getMockInstallers() =>
//     _allUsers.where((u) => u.isInstaller).toList();
//
// List<UserEntity> getMockAllUsers() => List.unmodifiable(_allUsers);
//
// void mockDeleteUser(String userId) {
//   _allUsers.removeWhere((u) => u.id == userId);
// }
//
// void mockCreateInstaller(Map<String, dynamic> data) {
//   final user = UserEntity(
//     id: 'user-${_uuid.v4().substring(0, 8)}',
//     name: data['name'] as String? ?? '',
//     email: data['email'] as String? ?? '',
//     role: 'installer',
//     phone: data['phone'] as String?,
//   );
//   _allUsers.add(user);
// }
