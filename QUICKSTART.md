# RED EDGE - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Generate Code
```bash
cd D:\Desktop\redEdge
dart run build_runner build --delete-conflicting-outputs
```

This generates:
- Freezed model classes
- JSON serialization code
- Riverpod providers
- Hive adapters

### Step 2: Run the App
```bash
flutter run
```

**First screen you'll see**: LoginScreen  
**Demo credentials**: 
- Email: `installer@rededge.io`
- Password: `demo123`

### Step 3: Test Offline-First
1. Login successfully
2. Go to Jobs tab
3. **Kill your WiFi** (airplane mode)
4. Try navigating - **everything still works!**
5. Turn WiFi back on - **automatic sync**

---

## 📁 Important Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App bootstrap - Hive init, DI setup |
| `lib/core/di/providers.dart` | Dependency injection container |
| `lib/core/router/app_router.dart` | Navigation routes & guards |
| `pubspec.yaml` | Dependencies (run `flutter pub get`) |

---

## 🔧 Configure Your API

Edit `lib/core/di/providers.dart`:

```dart
getIt.registerSingleton<ApiClient>(
  ApiClient(
    baseUrl: 'https://YOUR_API_HERE.com',  // ← Change this
    storage: getIt<SecureStorage>() as SecureStorageImpl,
  ),
);
```

---

## 📝 Project Structure

```
features/
├── auth/           # Login, authentication
├── jobs/           # Job list, job detail, steps
├── photos/         # Camera, photo review
└── settings/       # Settings screen

core/
├── network/        # API client, network info
├── storage/        # Hive DB, secure token storage
├── constants/      # Colors, typography, spacing
└── router/         # Navigation
```

---

## 🎯 Key Concepts

### 1. **Clean Architecture**
- **Domain**: Business logic (entities, repositories, use cases)
- **Data**: API calls, local DB (models, datasources)
- **Presentation**: UI (screens, widgets, providers)

### 2. **Offline-First**
- Read from local Hive DB first → instant display
- If online, fetch remote data in background
- All writes → local DB immediately
- SyncManager handles queueing offline operations

### 3. **State Management (Riverpod)**
```dart
// Watch a provider
final jobs = ref.watch(jobsNotifierProvider);

// Use AsyncValue pattern
jobs.when(
  data: (data) => Display(data),
  loading: () => Skeleton(),
  error: (e, st) => Error(e),
);
```

### 4. **Error Handling**
```dart
// Either<Failure, Success>
final result = await repository.getJobs();
result.fold(
  (failure) => print(failure.message),
  (success) => print(success),
);
```

---

## 🧪 Test Flows

### Login Flow
```
LoginScreen
  ↓ (enter email/password)
  ↓ (tap Sign In)
  ↓ (AuthProvider calls LoginUseCase)
  ↓ (token saved to SecureStorage)
  → JobListScreen
```

### Job View Flow
```
JobListScreen
  ↓ (tap job card)
  → JobDetailScreen
    ↓ (tap step)
    ↓ (tap "Capture Photo")
    → CameraScreen
      ↓ (tap capture)
      → PhotoReviewScreen
        ↓ (tap "Save Photo")
        → JobDetailScreen
```

### Offline Sync
```
Offline Step Completion
  ↓ (saves to local Hive)
  ↓ (queued in sync_queue box)
  ↓ (connectivity listener detects online)
  → SyncManager.flush()
    ↓ (processes queue)
    → API POST /jobs/:id/steps/:stepId
    ✅ (marked as done)
```

---

## 🔐 Security Features

| Feature | Implementation |
|---------|---|
| JWT Tokens | Stored in FlutterSecureStorage (encrypted) |
| API Auth | AuthInterceptor adds `Authorization: Bearer <token>` |
| Permissions | Request camera/location only when needed |
| Logs | Never log tokens or sensitive data in release builds |

---

## 📱 Screens Overview

### LoginScreen (`/login`)
- Email & password fields
- "Remember me" checkbox
- Feature bullets (Mobile-Optimised, Offline, Secure)
- Sign In button with loading state

### JobListScreen (`/jobs`)
- Red AppBar with "My Installations" title
- Filter dropdowns (Status, System Type)
- Job cards showing ID, title, location, date, progress
- Pull-to-refresh
- Bottom nav to Settings

### JobDetailScreen (`/jobs/:id`)
- Red collapsible header with job details
- Installation progress bar
- Step list (checkbox, photo indicator, notes)
- Bottom "Complete Installation" button

### CameraScreen (`/jobs/:id/steps/:stepId/camera`)
- Live camera preview
- Frame overlay (corner brackets)
- GPS coordinates pill (bottom-left)
- Large red capture button (center-bottom)
- Back button (top-left)

### PhotoReviewScreen (`/jobs/:id/steps/:stepId/photo-review`)
- Photo preview (rounded card)
- GPS coordinates display
- Optional annotation field
- Retake button (grey, left)
- Save Photo button (green, right)

### SettingsScreen (`/settings`)
- Profile card with avatar
- App info table (Version, Build, Environment)
- Logout button
- Bottom nav back to Jobs

---

## 🐛 Debugging Tips

### Check Hive Box Contents
```dart
// In main.dart after Hive init
final userBox = await Hive.openBox<UserModel>('users');
print(userBox.keys);  // See all stored users
print(userBox.get('user_id'));  // Inspect specific user
```

### Monitor API Calls
Open DevTools:
```bash
flutter pub global activate devtools
devtools
```

Then run:
```bash
flutter run --vm-service-port=8888
```

### Check Connectivity Status
```dart
// Add this temporary provider debug
print(await networkInfo.isConnected);  // true/false
```

---

## 📚 Learn More

- **Riverpod Docs**: https://riverpod.dev
- **Go Router**: https://pub.dev/packages/go_router
- **Hive**: https://docs.hivedb.dev
- **Clean Architecture**: https://resocoder.com/clean-architecture-tdd

---

## ✅ Checklist Before Production

- [ ] Run `flutter analyze` - fix all warnings
- [ ] Generate code: `dart run build_runner build`
- [ ] Run unit tests: `flutter test`
- [ ] Test offline flow (disable WiFi)
- [ ] Test iOS permissions (camera, location)
- [ ] Test Android permissions (camera, location)
- [ ] Set API base URL
- [ ] Configure Firebase Crashlytics
- [ ] Build release APK: `flutter build apk --release`
- [ ] Build release IPA: `flutter build ipa --release`

---

## 🚨 Common Problems & Solutions

### "Provider not found"
```
Error: Unable to find provider
```
**Solution**: Ensure `setupProviders()` is called in main.dart before `runApp()`

### "Hive box not found"
```
Error: Box not registered
```
**Solution**: Register adapters before opening boxes:
```dart
Hive.registerAdapter(UserModelAdapter());
await Hive.openBox<UserModel>('users');
```

### "Camera permission denied"
```
Error: Camera permission is not granted
```
**Solution**: Add to AndroidManifest.xml:
```xml
<uses-permission android:name="android.permission.CAMERA" />
```

### "API 401 unauthorized"
```
Error: 401 Unauthorized
```
**Solution**: Check SecureStorage has token:
```dart
final token = await secureStorage.read('auth_token');
print('Token: $token');  // Should not be null
```

---

## 📞 Support

For issues, check:
1. IMPLEMENTATION_COMPLETE.md - Full feature list
2. README_APP.md - Detailed documentation
3. Code comments in key files

**Contact**: support@rededge.io

---

**Ready to build? Run this now:**
```bash
cd D:\Desktop\redEdge
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

✅ You're all set!

