import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:red_edge_app/core/network/api_client.dart';
import 'package:red_edge_app/core/network/api_config.dart';
import 'package:red_edge_app/core/network/network_info.dart';
import 'package:red_edge_app/core/storage/token_storage.dart';
import 'package:red_edge_app/core/sync/sync_manager.dart';

// ── Repositories ──
import 'package:red_edge_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:red_edge_app/features/jobs/domain/repositories/job_repository.dart';
import 'package:red_edge_app/features/photos/domain/repositories/photo_repository.dart';

// ── Real Repositories ──
import 'package:red_edge_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:red_edge_app/features/jobs/data/repositories/job_repository_impl.dart';
import 'package:red_edge_app/features/photos/data/repositories/photo_repository_impl.dart';

// ── Mock Repositories ──
import 'package:red_edge_app/di/mock_repositories.dart';

// ── Use Cases ──
import 'package:red_edge_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:red_edge_app/features/jobs/domain/usecases/get_jobs_usecase.dart';
import 'package:red_edge_app/features/jobs/domain/usecases/complete_step_usecase.dart';
import 'package:red_edge_app/features/photos/domain/usecases/save_photo_usecase.dart';

final getIt = GetIt.instance;

// ╔═══════════════════════════════════════════════════════╗
// ║  FLIP THIS TO false WHEN YOUR BACKEND IS RUNNING     ║
// ╚═══════════════════════════════════════════════════════╝
const bool useMockData = false;

void setupGetIt() {
  // ── Core ──────────────────────────────────────────────
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage());

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: ApiConfig.baseUrl,
      tokenStorage: getIt<TokenStorage>(),
    ),
  );

  getIt.registerLazySingleton<SyncManager>(
    () => SyncManager(
      api: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // ── Repositories ──────────────────────────────────────
  if (useMockData) {
    getIt.registerLazySingleton<AuthRepository>(
      () => MockAuthRepository(),
    );
    getIt.registerLazySingleton<JobRepository>(
      () => MockJobRepository(),
    );
    getIt.registerLazySingleton<PhotoRepository>(
      () => MockPhotoRepository(),
    );
  } else {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        api: getIt<ApiClient>(),
        tokenStorage: getIt<TokenStorage>(),
      ),
    );
    getIt.registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(
        api: getIt<ApiClient>(),
      ),
    );
    getIt.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(
        api: getIt<ApiClient>(),
        syncManager: getIt<SyncManager>(),
      ),
    );
  }

  // ── Use Cases ─────────────────────────────────────────
  getIt.registerLazySingleton(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetJobsUseCase(getIt<JobRepository>()),
  );
  getIt.registerLazySingleton(
    () => CompleteStepUseCase(getIt<JobRepository>()),
  );
  getIt.registerLazySingleton(
    () => SavePhotoUseCase(getIt<PhotoRepository>()),
  );
}
