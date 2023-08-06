// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      role: json['role'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'name': instance.name,
      'gender': instance.gender,
    };
