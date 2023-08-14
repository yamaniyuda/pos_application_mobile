import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "role")
  late String? role;

  @JsonKey(name: "email")
  late String? email;

  @JsonKey(name: "phone_number")
  late String? phoneNumber;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "gender")
  late String? gender;

  UserDTO({
    this.role,
    this.gender,
    this.phoneNumber,
    this.name,
    this.email,
    this.id
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return _$UserDTOFromJson(json);
  }

  factory UserDTO.deserialize(String json) {
    return UserDTO.fromJson(jsonDecode(json));
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserDTOToJson(this);
  }

  String serialize() {
    return jsonEncode(toJson());
  }
}