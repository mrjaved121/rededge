// import 'package:fpdart/fpdart.dart';
// import 'package:red_edge_app/core/error/failures.dart';
// import 'package:red_edge_app/features/auth/domain/entities/user_entity.dart';
// import 'package:red_edge_app/features/auth/domain/repositories/auth_repository.dart';

// class MockAuthRepository implements AuthRepository {
//   @override
//   Future<Either<Failure, ({String token, UserEntity user})>> login(
//       String email,
//       String password,
//       ) async {
//     // Simulate network delay
//     await Future.delayed(const Duration(seconds: 1));

//     // Accept any email/password for testing
//     // In real app, this calls the API
//     if (email == 'test@rededge.com' && password == 'password') {
//       const user = UserEntity(
//         id: 'user-001',
//         name: 'John Smith',
//         email: 'test@rededge.com',
//         role: 'Field Installer',
//       );
//       return const Right((token: 'fake-jwt-token-12345', user: user));
//     }

//     // Also accept any non-empty credentials for easy testing
//     if (email.contains('@') && password.length >= 6) {
//       final user = UserEntity(
//         id: 'user-001',
//         name: 'Test User',
//         email: email,
//         role: 'Field Installer',
//       );
//       return Right((token: 'fake-jwt-token-12345', user: user));
//     }

//     return const Left(AuthFailure('Invalid email or password'));
//   }

//   @override
//   Future<Either<Failure, void>> logout() async {
//     return const Right(null);
//   }

//   @override
//   Future<Either<Failure, UserEntity>> getCurrentUser() async {
//     return const Right(UserEntity(
//       id: 'user-001',
//       name: 'John Smith',
//       email: 'test@rededge.com',
//       role: 'Field Installer',
//     ));
//   }

//   @override
//   Future<bool> isAuthenticated() async {
//     return false;
//   }
// }