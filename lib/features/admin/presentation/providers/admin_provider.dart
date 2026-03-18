import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../di/injection.dart';
import '../../../../core/network/api_client.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../jobs/domain/entities/job_entity.dart';
import '../../../jobs/domain/repositories/job_repository.dart';

// All jobs for admin dashboard
final adminJobsProvider = FutureProvider<List<JobEntity>>((ref) async {
  final result = await getIt<JobRepository>().getJobs();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (jobs) => jobs,
  );
});

// Installers list
final installersProvider = FutureProvider<List<UserEntity>>((ref) async {
  final response = await getIt<ApiClient>().getInstallers();
  final data = response.data as Map<String, dynamic>;
  final usersRaw = data['installers'] as List<dynamic>? ?? [];
  return usersRaw.map((u) {
    final m = u as Map<String, dynamic>;
    return UserEntity(
      id: m['_id']?.toString() ?? m['id']?.toString() ?? '',
      name: m['name'] as String? ?? '',
      email: m['email'] as String? ?? '',
      role: m['role'] as String? ?? 'installer',
      phone: m['phone'] as String?,
    );
  }).toList();
});

// All users
final allUsersProvider = FutureProvider<List<UserEntity>>((ref) async {
  final response = await getIt<ApiClient>().getUsers();
  final data = response.data as Map<String, dynamic>;
  final usersRaw = data['users'] as List<dynamic>? ?? [];
  return usersRaw.map((u) {
    final m = u as Map<String, dynamic>;
    return UserEntity(
      id: m['_id']?.toString() ?? m['id']?.toString() ?? '',
      name: m['name'] as String? ?? '',
      email: m['email'] as String? ?? '',
      role: m['role'] as String? ?? 'installer',
      phone: m['phone'] as String?,
    );
  }).toList();
});

// System types list (fetched from API)
final systemTypesProvider = FutureProvider<List<String>>((ref) async {
  final response = await getIt<ApiClient>().getSystemTypes();
  final data = response.data as Map<String, dynamic>;
  final typesRaw = data['systemTypes'] as List<dynamic>? ?? [];
  return typesRaw
      .map((t) => (t as Map<String, dynamic>)['name'] as String)
      .toList();
});
