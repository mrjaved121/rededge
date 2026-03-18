import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient _api;

  const AuthRemoteDataSource(this._api);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _api.login(email, password);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw ServerException(message: 'Invalid credentials');
    }
  }
}