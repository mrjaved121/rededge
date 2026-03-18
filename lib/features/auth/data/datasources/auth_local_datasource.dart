// import 'package:hive_flutter/hive_flutter.dart';
// import '../models/user_model.dart';

// abstract class AuthLocalDataSource {
//   Future<void> cacheUser(UserModel user);
//   Future<UserModel?> getUser();
//   Future<void> clear();
// }

// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   static const String _userKey = 'current_user';
//   final Box<UserModel> box;

//   AuthLocalDataSourceImpl(this.box);

//   @override
//   Future<void> cacheUser(UserModel user) async {
//     await box.put(_userKey, user);
//   }

//   @override
//   Future<UserModel?> getUser() async {
//     return box.get(_userKey);
//   }

//   @override
//   Future<void> clear() async {
//     await box.clear();
//   }
// }

