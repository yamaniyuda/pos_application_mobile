import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';

class UserEntity extends Entity {
  final String? id;
  final String? role;
  final String? email;
  final String? phoneNumber;
  final String? name;
  final String? gender;

  UserEntity({
    this.name,
    this.id,
    this.email,
    this.phoneNumber,
    this.gender,
    this.role,
  });

  factory UserEntity.deserialize(String json) {
    Map<String, dynamic> cleanJson = jsonDecode(json);
    UserEntity data = UserEntity(
      name: cleanJson["name"],
      role: cleanJson["role"],
      gender: cleanJson["gender"],
      phoneNumber: cleanJson["phoneNumber"],
      email: cleanJson["email"],
      id: cleanJson["id"]
    );
    return data;
  }

  @override
  List<Object?> get props => [
    id, name, email, phoneNumber, gender, role
  ];

  @override
  Entity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? role
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      role: role ?? this.role
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "gender": gender,
      "role": role
    };
  }

  String serialize() {
    return jsonEncode(toJson());
  }
}