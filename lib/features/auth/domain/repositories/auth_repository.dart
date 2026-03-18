import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ({String token, UserEntity user})>> login(
    String email,
    String password,
  );

  Future<Either<Failure, ({String token, UserEntity user})>> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phone,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<bool> isAuthenticated();
}
