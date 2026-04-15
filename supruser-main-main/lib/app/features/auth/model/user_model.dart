// ignore_for_file: public_member_api_docs, sort_constructors_first
// models/user_model.dart
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String? phone;
  final DateTime? createdAt;
  final String userid;
  final String? dateOfBirth;
  final String? email;
  final String? gender;
  UserModel({
    required this.name,
    this.phone,
    this.createdAt,
    required this.userid,
    this.dateOfBirth,
    this.email,
    this.gender,
  });

  UserModel copyWith({
    String? name,
    String? phone,
    DateTime? createdAt,
    String? userid,
    String? dateOfBirth,
    String? email,
    String? gender,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      userid: userid ?? this.userid,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'userid': userid,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      userid: map['userid'] as String,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, phone: $phone, createdAt: $createdAt, userid: $userid, dateOfBirth: $dateOfBirth, email: $email, gender: $gender)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.createdAt == createdAt &&
        other.userid == userid &&
        other.dateOfBirth == dateOfBirth &&
        other.email == email &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        createdAt.hashCode ^
        userid.hashCode ^
        dateOfBirth.hashCode ^
        email.hashCode ^
        gender.hashCode;
  }
}
