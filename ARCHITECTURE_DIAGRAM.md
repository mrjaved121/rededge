# RED EDGE Flutter App - Architecture Diagram

## 🏗️ High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                       │
│                                                                 │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐            │
│  │ LoginScreen  │ │JobListScreen │ │CameraScreen  │ ...        │
│  └──────────────┘ └──────────────┘ └──────────────┘            │
│         ↓                ↓                ↓                      │
│  ┌──────────────────────────────────────────────────┐          │
│  │          Riverpod Providers & State               │          │
│  │  (authNotifier, jobsNotifier, filteredJobs...)   │          │
│  └──────────────────────────────────────────────────┘          │
│                        ↓                                         │
│  ┌──────────────────────────────────────────────────┐          │
│  │       Reusable Widgets                           │          │
│  │  (AppPrimaryButton, StatusBadge, JobCard...)    │          │
│  └──────────────────────────────────────────────────┘          │
└─────────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────────┐
│                        DOMAIN LAYER                             │
│                 (Business Logic, No Framework)                  │
│                                                                 │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐            │
│  │    Entities  │ │  Use Cases   │ │Repositories  │            │
│  │              │ │              │ │  (abstract)  │            │
│  │ JobEntity    │ │GetJobsUseCase│ │JobRepository │            │
│  │ StepEntity   │ │CompleteStep  │ │AuthRepository│            │
│  │ PhotoEntity  │ │LoginUseCase  │ │              │            │
│  │ UserEntity   │ │LogoutUseCase │ │              │            │
│  └──────────────┘ └──────────────┘ └──────────────┘            │
└─────────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────────┐
│                        DATA LAYER                               │
│            (Implementation of Domain Contracts)                 │
│                                                                 │
│  ┌─────────────────────────────────────────────────────┐       │
│  │          Repository Implementations                 │       │
│  │  (JobRepositoryImpl, AuthRepositoryImpl)            │       │
│  │                   ↑ ↓                              │       │
│  └─────────────────────────────────────────────────────┘       │
│         ↓                           ↓                           │
│  ┌──────────────────┐       ┌──────────────────┐              │
│  │  Remote Data     │       │  Local Data      │              │
│  │  Sources         │       │  Sources         │              │
│  │                  │       │                  │              │
│  │ API Client (Dio) │       │ Hive Database    │              │
│  │ with Auth        │       │ (Local Storage)  │              │
│  │ Interceptor      │       │                  │              │
│  └──────────────────┘       └──────────────────┘              │
│         ↓                           ↓                           │
│  ┌──────────────────┐       ┌──────────────────┐              │
│  │   Backend API    │       │ Mobile Device    │              │
│  │                  │       │ Local Disk       │              │
│  │ /auth/login      │       │ (encrypted)      │              │
│  │ /jobs            │       │                  │              │
│  │ /jobs/:id        │       │ • JobModel       │              │
│  │ /upload          │       │ • UserModel      │              │
│  │ /sync            │       │ • PhotoModel     │              │
│  └──────────────────┘       │ • SyncQueue      │              │
│                              └──────────────────┘              │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Data Flow - Getting Jobs

```
User opens app
    ↓
ref.watch(jobsNotifierProvider)
    ↓
JobsNotifier.build()
    ↓
GetJobsUseCase.call()
    ↓
JobRepository.getJobs()
    ↓
    ├─→ Check networkInfo.isConnected
    │
    ├─ Online ──→ RemoteDS.getJobs() ──→ [API Call]
    │                    ↓
    │           [Cache result locally]
    │                    ↓
    │           [Return remote data]
    │
    └─ Offline ──→ LocalDS.getJobs() ──→ [Read from Hive]
                           ↓
                  [Return cached data]
    ↓
Models → Entities (toEntity())
    ↓
Riverpod updates widget
    ↓
UI refreshes with data
```

---

## 🔀 Authentication Flow

```
┌─────────────┐
│ LoginScreen │
└──────┬──────┘
       │ User enters email/password
       ↓
┌──────────────────────┐
│ AuthNotifier.login() │
└──────┬───────────────┘
       │ Calls LoginUseCase
       ↓
┌──────────────────────────────┐
│ AuthRepository.login()       │
└──────┬───────────────────────┘
       │ 1. RemoteDS.login(email, password)
       ↓
┌──────────────────────────┐
│ API POST /auth/login     │ ← Network Request
└──────┬───────────────────┘
       │ Returns (user, token)
       ↓
2. Save token → SecureStorage (encrypted)
3. Save user → LocalDS (Hive)
       ↓
4. Return UserEntity to AuthNotifier
       ↓
5. AuthState becomes authenticated()
       ↓
6. GoRouter redirect to /jobs
       ↓
┌─────────────┐
│JobListScreen│
└─────────────┘
```

---

## 📱 Screen Navigation Tree

```
/login ────→ LoginScreen
             (public - no auth required)
             
                    ↓ (successful login)

/jobs ─────→ JobListScreen
             (protected - auth required)
             ├─ Bottom Nav ──→ /settings
             └─ Job Card ────→ /jobs/:id
                    │
                    ↓
                    
/jobs/:id ──→ JobDetailScreen
              (shows steps)
              ├─ Step Card ──→ Camera
              └─ Step Card ──→ Step Detail
                    │
                    ↓
                    
/jobs/:id/steps/:stepId/camera
    ↓
CameraScreen (capture photo)
    │
    └─→ PhotoReviewScreen
         ├─ Retake ──→ CameraScreen
         └─ Save ───→ JobDetailScreen

/settings ──→ SettingsScreen
              ├─ Logout ──→ /login
              └─ Back ────→ /jobs
```

---

## 🔌 Dependency Injection Container (GetIt)

```
┌────────────────────────────────────────────────────────┐
│           GetIt Service Locator (main.dart)            │
├────────────────────────────────────────────────────────┤
│                                                        │
│  NetworkInfo ──→ Connectivity()                       │
│                                                        │
│  SecureStorage ──→ FlutterSecureStorage               │
│                                                        │
│  ApiClient ──→ Dio (with interceptors)                │
│       ├─ AuthInterceptor (Bearer token)              │
│       ├─ RetryInterceptor (auto-retry)               │
│       └─ LogInterceptor (debug logs)                 │
│                                                        │
│  HiveService ──→ HiveServiceImpl()                     │
│                                                        │
│  AuthRemoteDataSource ──→ AuthRemoteDataSourceImpl()  │
│  AuthLocalDataSource ──→ AuthLocalDataSourceImpl()    │
│                                                        │
│  JobRemoteDataSource ──→ JobRemoteDataSourceImpl()    │
│  JobLocalDataSource ──→ JobLocalDataSourceImpl()      │
│                                                        │
│  SyncManager ──→ SyncManagerImpl()                     │
│                                                        │
└────────────────────────────────────────────────────────┘
        ↓ (setupProviders() called in main)
        ↓
   All services available via getIt<Type>()
```

---

## 🔒 Security Layers

```
┌─ Presentation Layer ─────────────────────┐
│ GoRouter with auth guards               │
│ Redirect to /login if not authenticated │
└─────────────────────────────────────────┘
           ↓
┌─ Domain Layer ──────────────────────────┐
│ Use cases check for business rules      │
│ No sensitive data exposed               │
└─────────────────────────────────────────┘
           ↓
┌─ Data Layer ────────────────────────────┐
│ AuthInterceptor adds Bearer token       │
│ Token stored in SecureStorage           │
│ API calls over HTTPS                    │
└─────────────────────────────────────────┘
           ↓
┌─ Device Storage ────────────────────────┐
│ Photos in private app directory         │
│ Token encrypted (Keychain/Keystore)    │
│ Local DB (Hive) encrypted on device    │
└─────────────────────────────────────────┘
```

---

## 💾 Offline-First Data Flow

```
User completes a step (offline)
    ↓
StepCard checkbox tapped
    ↓
Repository.completeStep(jobId, stepId)
    ↓
1. IMMEDIATE: Write to local Hive
   - StepModel marked as completed
   - Local update visible instantly
    ↓
2. QUEUE: Create SyncOperation
   - Stored in 'sync_queue' box
   - ID, payload, retry count, status
    ↓
3. TRY REMOTE: If online
   - PATCH /jobs/:id/steps/:stepId
   - Mark SyncOperation as 'done'
    ↓
4. IF OFFLINE: Keep in queue
   - Retry every connection change
   - Max 5 retries with exponential backoff
    ↓
When internet restored:
    ↓
ConnectivityProvider stream detects online
    ↓
ref.listen() triggers SyncManager.flush()
    ↓
Process all pending operations
    ↓
API syncs successfully
    ↓
SyncOperation marked 'done'
    ↓
User sees no data loss ✅
```

---

## 🧠 State Management Pattern

```
┌─────────────────────────────────────────┐
│      Widget calls ref.watch()            │
└────────────┬────────────────────────────┘
             ↓
┌─────────────────────────────────────────┐
│    Riverpod Provider returns value       │
│  (cached if already computed)            │
└────────────┬────────────────────────────┘
             ↓
    ┌────────┴────────┐
    │                 │
    ↓                 ↓
AsyncValue<T>    StateNotifier
    │
    ├─ data(T)       ─→ Use case executes
    ├─ loading()     ─→ Repository reads
    └─ error(e)      ─→ Models convert
                     ─→ Widget rebuilds
    
Widget rebuilds when:
- Provider value changes
- Dependency provider changes
- Manual invalidate()
```

---

## 🗄️ Database Schema (Hive Boxes)

```
Hive Boxes:
├─ Box<UserModel> 'users'
│  ├─ Key: user_id
│  └─ Value: UserModel (email, name, role, company)
│
├─ Box<JobModel> 'jobs'
│  ├─ Key: job_id
│  └─ Value: JobModel (title, steps, status, progress)
│              ├─ Contains List<StepModel>
│              │  └─ Contains List<PhotoModel>
│
├─ Box<SyncOperation> 'sync_queue'
│  ├─ Key: operation_id (UUID)
│  └─ Value: SyncOperation (type, payload, retryCount, status)
│
└─ Box<dynamic> 'auth'
   ├─ 'auth_token' → JWT token string
   └─ 'user' → UserModel JSON
```

---

## 🎯 Feature-Based Architecture

```
Feature Module = Domain + Data + Presentation

auth/
├─ domain/
│  ├─ entities/
│  │  └─ user_entity.dart
│  ├─ repositories/
│  │  └─ auth_repository.dart (abstract)
│  └─ usecases/
│     └─ auth_usecases.dart (Login, Logout, etc)
│
├─ data/
│  ├─ models/
│  │  └─ user_model.dart (Freezed + Hive)
│  ├─ datasources/
│  │  ├─ auth_remote_datasource.dart
│  │  └─ auth_local_datasource.dart
│  └─ repositories/
│     └─ auth_repository_impl.dart
│
└─ presentation/
   ├─ screens/
   │  └─ login_screen.dart
   ├─ providers/
   │  └─ auth_provider.dart (Riverpod)
   └─ models/
      └─ auth_state.dart (Freezed)

Same structure for:
- jobs/ (job management)
- photos/ (camera)
- settings/ (settings)
```

---

## 🎨 UI Component Hierarchy

```
RedEdgeApp (MaterialApp.router)
    ↓
GoRouter (navigation)
    ├─ LoginScreen
    │  └─ LoginCard
    │     ├─ AppPrimaryButton
    │     └─ TextField
    │
    ├─ JobListScreen
    │  ├─ JobFilterBar
    │  │  └─ FilterDropdown (×2)
    │  ├─ ListView
    │  │  └─ JobCard (×N)
    │  │     ├─ StatusBadge
    │  │     ├─ SystemChip
    │  │     └─ ProgressBar
    │  └─ AppBottomNav
    │
    ├─ JobDetailScreen
    │  ├─ SliverAppBar
    │  │  └─ JobDetailHeader
    │  ├─ InstallationProgressBar
    │  ├─ SliverList
    │  │  └─ StepCard (×N)
    │  │     ├─ Checkbox
    │  │     ├─ PhotoCountBadge
    │  │     └─ CapturePhotoButton
    │  └─ AppPrimaryButton
    │
    ├─ CameraScreen
    │  ├─ CameraPreview
    │  ├─ FrameOverlay
    │  ├─ GPSPill
    │  └─ CaptureButton
    │
    ├─ PhotoReviewScreen
    │  ├─ Image.file()
    │  ├─ GPSCard
    │  ├─ AnnotationField
    │  ├─ AppOutlineButton
    │  └─ AppPrimaryButton
    │
    └─ SettingsScreen
       ├─ ProfileCard
       ├─ AppInfoTable
       └─ AppPrimaryButton (Logout)

OfflineBanner (Overlay)
    └─ Shows when connectivity == offline
```

---

## 🔄 Error Handling Flow

```
Try Operation
    ↓
┌───────────────┐
│ Exception?    │
└───┬───────────┘
    │
    ├─ DioException ──→ ServerFailure(code, message)
    ├─ HiveError ───→ CacheFailure(message)
    ├─ Permission ──→ PermissionFailure(message)
    └─ Other ──────→ UnknownFailure(message)
    ↓
Either<Failure, T>
    ├─ Left(failure) ──→ Show error UI
    └─ Right(success) ─→ Update state
    
Error UI:
├─ Snackbar with message
├─ Retry button
└─ Back button
```

---

## ✨ Summary

**3 Layers**: Domain (logic) → Data (integration) → Presentation (UI)  
**4 Patterns**: Clean Arch, Repository, Use Case, Provider  
**6 Screens**: Login, Jobs, Detail, Camera, Review, Settings  
**5 Widgets**: Button, Badge, Card, Banner, Nav  
**1 Database**: Hive (local-first)  
**1 State Manager**: Riverpod (reactive)  
**1 Router**: GoRouter (navigation)  
**1 API Client**: Dio (HTTP with interceptors)  

= **📱 Production-Ready App** ✅

