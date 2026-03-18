import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:red_edge_app/core/error/failures.dart';
import 'package:red_edge_app/features/auth/domain/entities/user_entity.dart';
import 'package:red_edge_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:red_edge_app/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
  });

  const tUser = UserEntity(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    role: 'Installer',
  );

  group('LoginUseCase', () {
    test('should return ValidationFailure for empty email', () async {
      final result = await useCase('', 'password123');

      expect(result.isLeft(), true);
      result.fold(
            (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(
            (failure as ValidationFailure).fieldErrors.containsKey('email'),
            true,
          );
        },
            (_) => fail('Should have returned failure'),
      );
    });

    test('should return ValidationFailure for short password', () async {
      final result = await useCase('test@test.com', '123');

      expect(result.isLeft(), true);
      result.fold(
            (failure) => expect(failure, isA<ValidationFailure>()),
            (_) => fail('Should have returned failure'),
      );
    });

    test('should return token and user on success', () async {
      when(() => mockRepo.login(any(), any())).thenAnswer(
            (_) async => Right((token: 'jwt-token', user: tUser)),
      );

      final result = await useCase('test@test.com', 'password123');

      expect(result.isRight(), true);
      result.fold(
            (failure) => fail('Should have succeeded'),
            (data) {
          expect(data.token, 'jwt-token');
          expect(data.user.name, 'John Doe');
        },
      );
      verify(() => mockRepo.login('test@test.com', 'password123')).called(1);
    });

    test('should return AuthFailure for wrong credentials', () async {
      when(() => mockRepo.login(any(), any())).thenAnswer(
            (_) async => const Left(AuthFailure('Invalid credentials')),
      );

      final result = await useCase('test@test.com', 'wrongpass');

      expect(result.isLeft(), true);
      result.fold(
            (failure) => expect(failure, isA<AuthFailure>()),
            (_) => fail('Should have returned failure'),
      );
    });
  });
}