// import '../../../../core/network/api_client.dart';
// import '../models/user_model.dart';
//
// abstract class AuthRemoteDataSource {
//   Future<(UserModel, String token)> login(String email, String password);
//   Future<UserModel> getCurrentUser();
// }
//
// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final ApiClient apiClient;
//
//   AuthRemoteDataSourceImpl(this.apiClient);
//
//   @override
//   Future<(UserModel, String)> login(String email, String password) async {
//     try {
//       final response = await apiClient.post(
//         '/auth/login',
//         data: {'email': email, 'password': password},
//         fromJson: (json) => json,
//       );
//       final user = UserModel.fromJson(response['user']);
//       final token = response['token'] as String;
//       return (user, token);
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<UserModel> getCurrentUser() async {
//     try {
//       final response = await apiClient.get(
//         '/auth/me',
//         fromJson: (json) => json,
//       );
//       return UserModel.fromJson(response);
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
//
