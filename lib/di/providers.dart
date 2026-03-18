// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:red_edge_app/features/jobs/data/datasources/job_local_datasource.dart';
// import 'package:red_edge_app/features/jobs/data/datasources/job_remote_datasource.dart';
// import 'package:red_edge_app/features/jobs/data/models/job_model.dart';
// import '../../core/network/api_client.dart';
// import '../../core/network/network_info.dart';
// import '../../core/storage/hive_service.dart';
// import '../../core/storage/secure_storage.dart';
// import '../../features/auth/data/datasources/auth_local_datasource.dart';
// import '../../features/auth/data/datasources/auth_remote_datasource.dart';
// import '../../features/jobs/data/datasources/job_local_datasource.dart';
// import '../../features/jobs/data/datasources/job_remote_datasource.dart';
// import '../../features/auth/data/models/user_model.dart';
// import '../../features/jobs/data/models/job_model.dart';
//
// final getIt = GetIt.instance;
//
// // Network & Storage
// final networkInfoProvider = Provider<NetworkInfo>((ref) {
//   return getIt<NetworkInfo>();
// });
//
// final apiClientProvider = Provider<ApiClient>((ref) {
//   return getIt<ApiClient>();
// });
//
// final secureStorageProvider = Provider<SecureStorage>((ref) {
//   return getIt<SecureStorage>();
// });
//
// final hiveServiceProvider = Provider<HiveService>((ref) {
//   return getIt<HiveService>();
// });
//
// // Auth DataSources
// final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
//   return getIt<AuthRemoteDataSource>();
// });
//
// final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
//   return getIt<AuthLocalDataSource>();
// });
//
// // Job DataSources
// final jobRemoteDataSourceProvider = Provider<JobRemoteDataSource>((ref) {
//   return getIt<JobRemoteDataSource>();
// });
//
// final jobLocalDataSourceProvider = Provider<JobLocalDataSource>((ref) {
//   return getIt<JobLocalDataSource>();
// });
//
// // Setup
// void setupProviders() {
//   // Network & Storage
//   getIt.registerSingleton<NetworkInfo>(
//     NetworkInfoImpl(Connectivity()),
//   );
//
//   getIt.registerSingleton<SecureStorage>(
//     SecureStorageImpl(const FlutterSecureStorage()),
//   );
//
//   getIt.registerSingleton<HiveService>(HiveServiceImpl());
//
//   getIt.registerSingleton<ApiClient>(
//     ApiClient(
//       baseUrl: const String.fromEnvironment('API_URL', defaultValue: 'https://api.rededge.io'),
//       storage: getIt<SecureStorage>() as SecureStorageImpl,
//     ),
//   );
//
//   // Auth DataSources
//   getIt.registerSingleton<AuthRemoteDataSource>(
//     AuthRemoteDataSourceImpl(getIt<ApiClient>()),
//   );
//
//   getIt.registerSingleton<AuthLocalDataSource>(
//     AuthLocalDataSourceImpl(Hive.box<UserModel>('users')),
//   );
//
//   // Job DataSources
//   getIt.registerSingleton<JobRemoteDataSource>(
//     JobRemoteDataSourceImpl(getIt<ApiClient>()),
//   );
//
//   getIt.registerSingleton<JobLocalDataSource>(
//     JobLocalDataSourceImpl(Hive.box<JobModel>('jobs')),
//   );
// }
//
