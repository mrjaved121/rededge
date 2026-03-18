# RED EDGE Installation Management Flutter App

**Production-Ready • Offline-First • Field-Optimised**  
**Version 1.0 • March 2026**

RED EDGE is a comprehensive installation management application for field technicians. Built with Flutter using Clean Architecture and Riverpod state management, the app is designed to work seamlessly in offline environments with automatic synchronisation when connectivity is restored.

## Key Features

✅ **Offline-First Architecture** - Complete functionality without internet connection  
✅ **Clean Architecture** - Clearly separated domain, data, and presentation layers  
✅ **State Management** - Riverpod with code generation for scalability  
✅ **Secure Authentication** - JWT tokens with secure storage (Keychain/Keystore)  
✅ **Camera Integration** - Photo capture with GPS watermarking  
✅ **Automatic Sync Queue** - Pending operations sync when connectivity restored  
✅ **Mobile-Optimised UI** - Red design system with accessibility in mind  
✅ **Production-Ready** - Error handling, logging, crash reporting ready  

## Project Structure

```
lib/
├── core/                          # Shared code
│   ├── constants/                 # AppColors, AppTextStyles, AppSpacing
│   ├── error/                     # Failures, Exceptions
│   ├── network/                   # ApiClient, NetworkInfo
│   ├── storage/                   # HiveService, SecureStorage
│   ├── sync/                      # SyncManager, SyncOperation
│   ├── utils/                     # DateUtils, ImageUtils, GpsUtils
│   ├── widgets/                   # AppPrimaryButton, StatusBadge, etc
│   ├── di/                        # Dependency injection setup
│   └── router/                    # GoRouter configuration
├── features/
│   ├── auth/
│   │   ├── data/                  # Datasources, models, repositories
│   │   ├── domain/                # Entities, usecases, abstract repos
│   │   └── presentation/          # Screens, providers, widgets
│   ├── jobs/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── photos/
│   │   └── presentation/
│   ├── settings/
│   │   └── presentation/
│   └── core/                      # Feature-level providers
├── app.dart                       # MaterialApp + GoRouter
└── main.dart                      # Bootstrap & Hive init
```

## Setup & Installation

### Prerequisites

- Flutter 3.24.0 or later
- Dart 3.10.4 or later
- Java 11+ (Android)
- Xcode 14+ (iOS)

### 1. Get Dependencies

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### 2. Configure Environment

Create `.env` file:

```
API_URL=https://api.rededge.io
ENVIRONMENT=production
```

### 3. Android Configuration

Edit `android/local.properties`:

```properties
sdk.dir=/path/to/Android/sdk
flutter.sdk=/path/to/flutter
```

### 4. iOS Configuration

Run pod install in ios/:

```bash
cd ios
pod install
cd ..
```

### 5. Run the App

```bash
# Debug
flutter run

# Release
flutter build apk --release
flutter build ipa --release
```

## Architecture Layers

### Domain Layer

- **Entities**: Core business objects (`JobEntity`, `StepEntity`, `UserEntity`)
- **Repositories** (abstract): Contracts for data access
- **UseCases**: Orchestrates business logic with repository calls

### Data Layer

- **Models**: JSON-serializable DTOs (freezed + json_serializable)
- **DataSources** (remote/local): API & Hive interactions
- **Repositories** (impl): Implements domain contracts with offline-first logic

### Presentation Layer

- **Screens**: Full-screen widgets (LoginScreen, JobListScreen, etc)
- **Providers**: Riverpod state management with async support
- **Widgets**: Reusable UI components (AppPrimaryButton, StatusBadge, etc)

## State Management (Riverpod)

All async operations use `AsyncNotifier`:

```dart
@riverpod
class JobsNotifier extends _$JobsNotifier {
  @override
  Future<List<JobEntity>> build() {
    return ref.read(getJobsUseCaseProvider).call();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    // ...
  }
}

// In widgets:
final jobsAsync = ref.watch(jobsNotifierProvider);
jobsAsync.when(
  data: (jobs) => ListView(...),
  loading: () => LoadingSkeletons(),
  error: (e, st) => ErrorView(),
);
```

## Offline-First Pattern

### How It Works

1. **Local Read**: Always read from Hive first (instant display)
2. **Background Sync**: If online, fetch remote data in background
3. **Queue Operations**: All writes (step completion, photos) → local DB immediately
4. **Sync on Connect**: When connectivity restored, SyncManager processes queue

### Example: Complete Step

```dart
// Always writes to local Hive first
await localDataSource.updateStep(jobId, stepId, isCompleted: true);

// If online, sync to backend
if (isConnected) {
  await remoteDataSource.completeStep(jobId, stepId);
}
```

## Security Features

| Area | Implementation |
|------|---|
| JWT Storage | FlutterSecureStorage (Keychain/Keystore) |
| API Auth | Bearer token via AuthInterceptor |
| Certificate Pinning | (Ready to integrate with `http_certificate_pinning`) |
| Logs | Never log tokens, passwords, or GPS in release builds |
| Photos | Stored in app documents directory (private) |

## Testing

Run all tests:

```bash
# Unit tests
flutter test

# With coverage
flutter test --coverage

# Integration tests
flutter drive --target=test_driver/app.dart
```

## Build & Release

### Android

```bash
# Generate keystore (first time only)
keytool -genkey -v -keystore release.jks -keyalg RSA -keysize 2048

# Build release APK
flutter build apk --release --obfuscate --split-debug-info=build/debug-info

# Build app bundle (preferred for Play Store)
flutter build appbundle --release
```

### iOS

```bash
# Build release IPA
flutter build ipa --release

# Or through Xcode
open ios/Runner.xcworkspace
# Select Product > Scheme > Runner (Release)
# Product > Build For > Generic iOS Device
# Then Organiser to upload
```

## Production Checklist

- [ ] Enable ProGuard/R8 obfuscation (Android)
- [ ] Configure code signing (iOS)
- [ ] Set up crash reporting (Firebase Crashlytics)
- [ ] Enable certificate pinning
- [ ] Test offline scenarios thoroughly
- [ ] Run `flutter analyze` and fix all warnings
- [ ] Write unit tests for critical paths
- [ ] Update version in pubspec.yaml
- [ ] Build signed APK/IPA
- [ ] Submit to Google Play / App Store

## Recommended Packages

See `pubspec.yaml` for full dependency list. Key packages:

- **flutter_riverpod** - State management with code generation
- **go_router** - Navigation with deep linking
- **hive_flutter** - Fast, lightweight local database
- **dio** - HTTP client with interceptors
- **camera** - Device camera access
- **geolocator** - GPS coordinates
- **flutter_secure_storage** - Secure token storage

## API Integration

The app communicates with Red Edge backend. Key endpoints:

```
POST   /auth/login          → Authenticate
GET    /jobs                → List assigned jobs
GET    /jobs/:id            → Get job details
PATCH  /jobs/:id/steps/:stepId → Mark step complete
POST   /photos/upload       → Upload photo with metadata
POST   /sync/flush          → Trigger server-side sync
```

## Troubleshooting

### Hive Registration Issues

Ensure all adapters are registered before opening boxes:

```dart
Hive.registerAdapter(UserModelAdapter());
Hive.registerAdapter(JobModelAdapter());
// ... etc
await Hive.openBox<UserModel>('users');
```

### Code Generation Not Running

```bash
dart run build_runner build --delete-conflicting-outputs
dart run build_runner clean  # If stuck
```

### Camera Permission Denied

Add permissions to `AndroidManifest.xml` and `Info.plist`:

**Android:**

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

**iOS** (`Info.plist`):

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture photos</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need location to record GPS coordinates</string>
```

## License

Proprietary — Red Edge Ltd 2026

## Support

For issues, contact: support@rededge.io

