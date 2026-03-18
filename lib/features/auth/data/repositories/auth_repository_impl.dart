import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  const AuthRepositoryImpl({
    required ApiClient api,
    required TokenStorage tokenStorage,
  })  : _api = api,
        _tokenStorage = tokenStorage;

  UserEntity _parseUser(Map<String, dynamic> data) {
    return UserEntity(
      id: data['id']?.toString() ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: data['role'] as String? ?? 'installer',
      phone: data['phone'] as String?,
    );
  }

  @override
  Future<Either<Failure, ({String token, UserEntity user})>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _api.login(email, password);
      final data = response.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = _parseUser(data['user'] as Map<String, dynamic>);
      await _tokenStorage.saveToken(token);
      // Cache user for offline access
      await _tokenStorage.saveUserData({
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'role': user.role,
        'phone': user.phone,
      });
      return Right((token: token, user: user));
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] as String? ?? 'Login failed';
      return Left(AuthFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ({String token, UserEntity user})>> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phone,
  }) async {
    try {
      final response = await _api.signup(
        name: name,
        email: email,
        password: password,
        role: role,
        phone: phone,
      );
      final data = response.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = _parseUser(data['user'] as Map<String, dynamic>);
      await _tokenStorage.saveToken(token);
      // Cache user for offline access
      await _tokenStorage.saveUserData({
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'role': user.role,
        'phone': user.phone,
      });
      return Right((token: token, user: user));
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] as String? ?? 'Signup failed';
      return Left(AuthFailure(msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _tokenStorage.clearToken();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final response = await _api.getMe();
      final data = response.data as Map<String, dynamic>;
      final user = _parseUser(data['user'] as Map<String, dynamic>);
      // Keep cached user up-to-date
      await _tokenStorage.saveUserData({
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'role': user.role,
        'phone': user.phone,
      });
      return Right(user);
    } on DioException {
      // Offline – use cached user if available
      final cached = await _tokenStorage.getUserData();
      if (cached != null) return Right(_parseUser(cached));
      return Left(const AuthFailure('Cannot reach server and no cached session'));
    } catch (e) {
      final cached = await _tokenStorage.getUserData();
      if (cached != null) return Right(_parseUser(cached));
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return _tokenStorage.hasToken;
  }
}
