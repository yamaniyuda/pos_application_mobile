// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_categoty_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothCategoryDTO _$ClothCategoryDTOFromJson(Map<String, dynamic> json) =>
    ClothCategoryDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ClothCategoryDTOToJson(ClothCategoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt,
    };
