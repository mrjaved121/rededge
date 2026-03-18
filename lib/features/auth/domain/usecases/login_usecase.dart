import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<Either<Failure, ({String token, UserEntity user})>> call(
      String email,
      String password,
      ) async {
    // Validate inputs
    if (email.isEmpty || !email.contains('@')) {
      return const Left(
        ValidationFailure(
          'Invalid email',
          fieldErrors: {'email': 'Please enter a valid email address'},
        ),
      );
    }
    if (password.isEmpty || password.length < 6) {
      return const Left(
        ValidationFailure(
          'Invalid password',
          fieldErrors: {'password': 'Password must be at least 6 characters'},
        ),
      );
    }

    return _repository.login(email, password);
  }
}