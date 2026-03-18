// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:red_edge_app/core/widgets/status_badge.dart';
// import 'package:red_edge_app/core/widgets/system_chip.dart';
// import 'package:red_edge_app/features/jobs/domain/entities/job_entity.dart';
// import 'package:red_edge_app/features/jobs/presentation/widgets/job_card.dart';

// void main() {
//   final tJob = JobEntity(
//     id: 'JOB-001',
//     title: 'Hemisphere VR-1000 Dozer Installation',
//     status: JobStatus.inProgress,
//     systemType: SystemType.hemisphereVR1000Dozer,
//     location: 'Brisbane QLD',
//     address: '123 Construction Way',
//     date: DateTime(2026, 3, 15),
//     completedSteps: 3,
//     totalSteps: 8,
//     company: 'BHP Mining Corp',
//   );

//   testWidgets('JobCard displays all job information', (tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: JobCard(
//             job: tJob,
//             onTap: () {},
//           ),
//         ),
//       ),
//     );

//     expect(find.text('JOB-001'), findsOneWidget);
//     expect(find.text('Hemisphere VR-1000 Dozer Installation'), findsOneWidget);
//     expect(find.text('Brisbane QLD'), findsOneWidget);
//     expect(find.text('IN PROGRESS'), findsOneWidget);
//     expect(find.text('Hemisphere'), findsOneWidget);
//     expect(find.text('3 of 8 steps'), findsOneWidget);
//   });

//   testWidgets('JobCard does not show progress bar for draft', (tester) async {
//     final draftJob = tJob.copyWith(status: JobStatus.draft);

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: JobCard(job: draftJob, onTap: () {}),
//         ),
//       ),
//     );

//     expect(find.text('DRAFT'), findsOneWidget);
//     expect(find.byType(LinearProgressIndicator), findsNothing);
//   });

//   testWidgets('JobCard calls onTap when pressed', (tester) async {
//     bool tapped = false;

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: JobCard(
//             job: tJob,
//             onTap: () => tapped = true,
//           ),
//         ),
//       ),
//     );

//     await tester.tap(find.byType(JobCard));
//     expect(tapped, true);
//   });
// }