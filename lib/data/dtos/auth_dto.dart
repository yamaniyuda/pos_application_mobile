import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'dto.dart';

part 'auth_dto.g.dart';

@JsonSerializable()
class AuthDTO implements DTO {
  @JsonKey(name: "token_type")
  late String? token;

  @JsonKey(name: "expires_in")
  late int? expiresIn;

  @JsonKey(name: "access_token")
  late String? accessToken;

  @JsonKey(name: "refresh_token")
  late String? refreshToken;

  AuthDTO({
    this.token,
    this.accessToken,
    this.expiresIn,
    this.refreshToken
  });

  factory AuthDTO.fromJson(Map<String, dynamic> json) {
    return _$AuthDTOFromJson(json);
  }

  factory AuthDTO.deserialize(String json) {
    return AuthDTO.fromJson(jsonDecode(json));
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AuthDTOToJson(this);
  }

  String serialize() {
    return jsonEncode(toJson());
  }
}