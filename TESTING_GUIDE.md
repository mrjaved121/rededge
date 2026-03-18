# 🧪 RED EDGE Flutter App - Testing Strategy Guide

**Status**: Testing framework ready, templates provided  
**Next Step**: Write tests following this guide  

---

## 📋 Testing Overview

The RED EDGE app is built with **100% testability** in mind:
- ✅ Clear layer separation (Domain, Data, Presentation)
- ✅ Dependency injection for easy mocking
- ✅ Use cases are pure functions
- ✅ Repositories have abstract interfaces
- ✅ DataSources can be mocked

---

## 🎯 Testing Pyramid

```
        △
       /│\
      / │ \    Integration Tests (10%)
     /  │  \   - Full user flows
    /───┼───\  - Multiple features
   /    │    \
  /     │     \
 / ─ ─ ─┼─ ─ ─ \ Widget Tests (30%)
/  ┌────┼────┐  \ - Individual screens
│  │    │    │   │ - Component rendering
│  │ Unit Tests (60%)
│  │ ├─ UseCases  │ - Repositories
│  │ ├─ Repos     │ - ValueObjects
│  │ └─ Models    │ - Providers
│  │            │
└──┴────────────┴──┘
   Foundation
```

---

## 🧬 Unit Tests (60% - Start Here)

### What to Test
- ✅ Use Cases (business logic)
- ✅ Repositories (data coordination)
- ✅ Value Objects (models)
- ✅ Providers (state logic)

### What NOT to Test
- ❌ Flutter framework code
- ❌ External dependencies (Dio, Hive)
- ❌ UI rendering

### Example: Test GetJobsUseCase

**File**: `test/features/jobs/domain/usecases/get_jobs_usecase_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rededge/features/jobs/domain/entities/job_entity.dart';
import 'package:rededge/features/jobs/domain/repositories/job_repository.dart';
import 'package:rededge/features/jobs/domain/usecases/job_usecases.dart';

// Mock repository
class MockJobRepository extends Mock implements JobRepository {}

void main() {
  group('GetJobsUseCase', () {
    late MockJobRepository mockRepository;
    late GetJobsUseCase useCase;

    setUp(() {
      mockRepository = MockJobRepository();
      useCase = GetJobsUseCase(mockRepository);
    });

    test('should return list of jobs from repository', () async {
      // Arrange
      final jobs = [
        JobEntity(
          id: 'JOB-001',
          title: 'Test Job',
          status: JobStatus.pending,
          systemType: SystemType.dualFreq,
          location: '45 km west',
          address: '123 Street',
          date: DateTime.now(),
          completedSteps: 0,
          totalSteps: 5,
          steps: [],
          company: 'Test Co',
        ),
      ];

      when(mockRepository.getJobs())
          .thenAnswer((_) async => Right(jobs));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should not fail'),
        (jobList) => expect(jobList.length, 1),
      );

      verify(mockRepository.getJobs()).called(1);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(mockRepository.getJobs()).thenAnswer(
        (_) async => Left(NetworkFailure()),
      );

      // Act
      final result = await useCase.call();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (jobs) => fail('Should not succeed'),
      );
    });
  });
}
```

### Test Setup Tips

Add to `pubspec.yaml`:
```yaml
dev_dependencies:
  mockito: ^5.4.0
  build_runner: ^2.4.9
  mockito_generate: ^5.4.0
```

Generate mocks:
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 🎨 Widget Tests (30% - UI Components)

### What to Test
- ✅ Screen renders correctly
- ✅ Button tap handlers work
- ✅ Form validation
- ✅ Loading/error states
- ✅ List items render

### What NOT to Test
- ❌ Navigation (use integration tests)
- ❌ API calls (mock them)
- ❌ Actual device features (camera, GPS)

### Example: Test JobCard Widget

**File**: `test/features/jobs/presentation/widgets/job_card_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rededge/features/jobs/domain/entities/job_entity.dart';
import 'package:rededge/features/jobs/presentation/screens/job_list_screen.dart';

void main() {
  group('JobCard Widget', () {
    late JobEntity testJob;

    setUp(() {
      testJob = JobEntity(
        id: 'JOB-001',
        title: 'Hemisphere VR Installation',
        status: JobStatus.inProgress,
        systemType: SystemType.hemisphereVR1000Dozer,
        location: '45 km west',
        address: '123 Main Street',
        date: DateTime(2026, 3, 13),
        completedSteps: 3,
        totalSteps: 5,
        steps: [],
        company: 'Test Company',
      );
    });

    testWidgets('should render job card correctly', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _JobCard(
              jobId: testJob.id,
              title: testJob.title,
              location: testJob.location,
              date: testJob.date.toString(),
              status: 'inProgress',
              progress: testJob.completedSteps,
              total: testJob.totalSteps,
              onTap: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('JOB-001'), findsOneWidget);
      expect(find.text('Hemisphere VR Installation'), findsOneWidget);
      expect(find.text('45 km west'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (WidgetTester tester) async {
      // Arrange
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _JobCard(
              jobId: testJob.id,
              title: testJob.title,
              location: testJob.location,
              date: testJob.date.toString(),
              status: 'inProgress',
              progress: 3,
              total: 5,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      // Assert
      expect(tapped, true);
    });

    testWidgets('should show progress bar for in-progress jobs',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _JobCard(
              jobId: testJob.id,
              title: testJob.title,
              location: testJob.location,
              date: testJob.date.toString(),
              status: 'inProgress',
              progress: 3,
              total: 5,
              onTap: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('3/5 steps'), findsOneWidget);
    });
  });
}
```

---

## 🔗 Integration Tests (10% - Full Flows)

### What to Test
- ✅ Complete user flows (login → jobs → detail)
- ✅ Navigation between screens
- ✅ State persistence across navigation
- ✅ Offline scenarios

### Testing Offline Flow

**File**: `test_driver/offline_flow_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rededge/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Offline Flow Test', () {
    testWidgets('should work offline', (WidgetTester tester) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();

      // Login
      await tester.enterText(find.byType(TextField).first, 'user@test.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Expect jobs loaded
      expect(find.text('My Installations'), findsOneWidget);

      // TODO: Disable network (platform-specific)
      // For now, just test that data persists

      // Navigate to job detail
      await tester.tap(find.byType(Card).first);
      await tester.pumpAndSettle();

      // Expect job detail loads
      expect(find.byType(SliverAppBar), findsOneWidget);

      // Navigate back
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Expect back on job list
      expect(find.text('My Installations'), findsOneWidget);
    });
  });
}
```

---

## 📊 Test Coverage

### Target Coverage
- Domain Layer: **100%** (use cases, repositories)
- Data Layer: **80%** (datasources, models)
- Presentation Layer: **60%** (key screens, providers)
- Overall: **70%+**

### Generate Coverage Report
```bash
flutter test --coverage
# Opens: coverage/index.html
```

### Coverage by Layer
```
Domain/   ▓▓▓▓▓▓▓▓▓▓ 100%
Data/     ▓▓▓▓▓▓▓▓░░  80%
Present/  ▓▓▓▓▓▓░░░░  60%
─────────────────────
Total:    ▓▓▓▓▓▓▓░░░  70%
```

---

## 🧪 Test Organization

### File Structure
```
test/
├── features/
│   ├── auth/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── login_usecase_test.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_ds_test.dart
│   │   │   │   └── auth_local_ds_test.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_test.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider_test.dart
│   │       └── screens/
│   │           └── login_screen_test.dart
│   │
│   ├── jobs/
│   │   ├── domain/
│   │   ├── data/
│   │   └── presentation/
│   │
│   └── (other features)
│
└── integration_test/
    ├── offline_flow_test.dart
    ├── auth_flow_test.dart
    └── job_flow_test.dart
```

### Naming Convention
- Test files: `*_test.dart`
- Test group: `group('ComponentName', () {`
- Test case: `test('should do X when Y', () {})`
- Widget test: `testWidgets('should do X', (tester) {})`

---

## ✅ Common Test Patterns

### Pattern 1: AAA (Arrange-Act-Assert)
```dart
test('should return jobs', () async {
  // ARRANGE - set up test conditions
  final jobs = [JobEntity(...)];
  when(repo.getJobs()).thenAnswer((_) async => Right(jobs));

  // ACT - perform the action
  final result = await useCase.call();

  // ASSERT - verify the result
  expect(result.isRight(), true);
});
```

### Pattern 2: Mock Repository
```dart
class MockJobRepository extends Mock implements JobRepository {}

final mockRepo = MockJobRepository();
when(mockRepo.getJobs()).thenAnswer((_) async => Right([...]));
```

### Pattern 3: Test Widget State
```dart
testWidgets('shows loading state', (tester) async {
  await tester.pumpWidget(app);
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

### Pattern 4: Test Navigation
```dart
testWidgets('navigates to job detail', (tester) async {
  await tester.pumpWidget(app);
  await tester.tap(find.byType(Card));
  await tester.pumpAndSettle();
  expect(find.text('Installation Progress'), findsOneWidget);
});
```

---

## 🚀 Running Tests

### Run all tests
```bash
flutter test
```

### Run specific test file
```bash
flutter test test/features/auth/domain/usecases/login_usecase_test.dart
```

### Run tests matching pattern
```bash
flutter test --name "should login"
```

### Run with coverage
```bash
flutter test --coverage
open coverage/index.html
```

### Watch mode
```bash
dart run build_runner watch
# In another terminal:
flutter test --reporter expanded
```

---

## 📝 Test Checklist

- [ ] Authentication
  - [ ] Login success
  - [ ] Login failure
  - [ ] Token storage
  - [ ] Logout

- [ ] Job Management
  - [ ] Get jobs list
  - [ ] Get job detail
  - [ ] Filter jobs
  - [ ] Complete step

- [ ] Offline Functionality
  - [ ] Read cached data
  - [ ] Queue operations
  - [ ] Sync on reconnect

- [ ] UI Components
  - [ ] Rendering
  - [ ] User interactions
  - [ ] Loading states
  - [ ] Error states

- [ ] Navigation
  - [ ] All routes accessible
  - [ ] Auth guards working
  - [ ] Deep linking works

- [ ] Error Handling
  - [ ] Network errors
  - [ ] Database errors
  - [ ] Permission errors

---

## 🔍 Debugging Tests

### Print debug info
```dart
test('debug test', () {
  print('TEST DEBUG: $variable');
  debugPrint('value: $value');
});
```

### Add breakpoints
- Flutter Inspector
- Set breakpoint in IDE
- Run with: `flutter run -d -v`

### Test single test
```bash
flutter test -k "test_name"
```

### Verbose output
```bash
flutter test -v
```

---

## 📚 Resources

- [Flutter Testing Docs](https://flutter.dev/docs/testing)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Integration Testing](https://flutter.dev/docs/testing/integration-tests)
- [Widget Testing](https://flutter.dev/docs/testing#unit-tests)

---

## ⏱️ Time Estimates

| Task | Time |
|------|------|
| Setup testing framework | 1 hour |
| Write domain layer tests | 3 hours |
| Write data layer tests | 4 hours |
| Write presentation tests | 3 hours |
| Write integration tests | 2 hours |
| Achieve 70% coverage | 13 hours |
| **TOTAL** | **~13 hours** |

---

## 🎯 Next Steps

1. Add mockito to pubspec.yaml
2. Create first test file following patterns above
3. Run tests: `flutter test`
4. Check coverage: `flutter test --coverage`
5. Improve coverage gradually

---

**Remember**: Tests are documentation. They show how code should be used.

**Start simple, test the happy path first, then edge cases.**

Happy testing! ✨

