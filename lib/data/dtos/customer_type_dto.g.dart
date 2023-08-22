// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerTypeDTO _$CustomerTypeDTOFromJson(Map<String, dynamic> json) =>
    CustomerTypeDTO(
      createdAt: json['created_at'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CustomerTypeDTOToJson(CustomerTypeDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt,
    };
