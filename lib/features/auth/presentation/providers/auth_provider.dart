import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:red_edge_app/di/injection.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/error/failures.dart';

// Auth state
class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final bool isInitializing;
  final UserEntity? user;
  final String? errorMessage;
  final Map<String, String> fieldErrors;

  const AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.isInitializing = true,
    this.user,
    this.errorMessage,
    this.fieldErrors = const {},
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    bool? isInitializing,
    UserEntity? user,
    String? errorMessage,
    Map<String, String>? fieldErrors,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isInitializing: isInitializing ?? this.isInitializing,
      user: user ?? this.user,
      errorMessage: errorMessage,
      fieldErrors: fieldErrors ?? this.fieldErrors,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  AuthNotifier({
    required LoginUseCase loginUseCase,
    required AuthRepository authRepository,
    required TokenStorage tokenStorage,
  })  : _loginUseCase = loginUseCase,
        _authRepository = authRepository,
        _tokenStorage = tokenStorage,
        super(const AuthState());

  Future<void> checkAuth() async {
    state = const AuthState(isInitializing: true);
    final hasToken = await _tokenStorage.hasToken;
    if (hasToken) {
      final result = await _authRepository.getCurrentUser();
      result.fold(
        (_) {
          _tokenStorage.clearToken();
          state = const AuthState(isInitializing: false);
        },
        (user) {
          state =
              AuthState(isLoggedIn: true, user: user, isInitializing: false);
        },
      );
    } else {
      state = const AuthState(isInitializing: false);
    }
  }

  Future<void> login(String email, String password, bool rememberMe) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      fieldErrors: {},
    );

    final result = await _loginUseCase(email, password);

    result.fold(
      (failure) {
        if (failure is ValidationFailure) {
          state = state.copyWith(
            isLoading: false,
            fieldErrors: failure.fieldErrors,
            errorMessage: failure.message,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          );
        }
      },
      (data) async {
        await _tokenStorage.saveToken(data.token);
        if (rememberMe) {
          await _tokenStorage.saveRememberedEmail(email);
        } else {
          await _tokenStorage.clearRememberedEmail();
        }
        state = AuthState(
          isLoggedIn: true,
          user: data.user,
          isInitializing: false,
        );
      },
    );
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phone,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      fieldErrors: {},
    );

    final result = await _authRepository.signup(
      name: name,
      email: email,
      password: password,
      role: role,
      phone: phone,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (data) async {
        state = AuthState(
          isLoggedIn: true,
          user: data.user,
        );
      },
    );
  }

  Future<void> logout() async {
    await _tokenStorage.clearToken();
    state = const AuthState(isInitializing: false);
  }

  Future<String?> getRememberedEmail() {
    return _tokenStorage.getRememberedEmail();
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    loginUseCase: getIt<LoginUseCase>(),
    authRepository: getIt<AuthRepository>(),
    tokenStorage: getIt<TokenStorage>(),
  );
});

final currentUserProvider = Provider<UserEntity?>((ref) {
  return ref.watch(authProvider).user;
});
