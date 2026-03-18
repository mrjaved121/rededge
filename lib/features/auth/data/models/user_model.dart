// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:hive/hive.dart';
// import '../../domain/entities/user_entity.dart';
//
// part 'user_model.freezed.dart';
// part 'user_model.g.dart';
//
// @HiveType(typeId: 0)
// @freezed
// class UserModel with _$UserModel {
//   const factory UserModel({
//     @HiveField(0) required String id,
//     @HiveField(1) required String email,
//     @HiveField(2) required String name,
//     @HiveField(3) required String role,
//     @HiveField(4) required String? company,
//   }) = _UserModel;
//
//   factory UserModel.fromJson(Map<String, dynamic> json) =>
//       _$UserModelFromJson(json);
//
//   factory UserModel.fromEntity(UserEntity entity) => UserModel(
//     id: entity.id,
//     email: entity.email,
//     name: entity.name,
//     role: entity.role,
//     company: entity.company,
//   );
// }
//
// extension UserModelX on UserModel {
//   UserEntity toEntity() => UserEntity(
//     id: id,
//     email: email,
//     name: name,
//     role: role,
//     company: company,
//   );
// }
//
