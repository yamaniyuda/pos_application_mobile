// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorDTO _$ColorDTOFromJson(Map<String, dynamic> json) => ColorDTO(
      name: json['name'] as String?,
      id: json['id'] as String?,
      createdAt: json['created_at'] as String?,
      codeHexa: json['code_hexa'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as int?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$ColorDTOToJson(ColorDTO instance) => <String, dynamic>{
      'id': instance.id,
      'is_active': instance.isActive,
      'name': instance.name,
      'description': instance.description,
      'code_hexa': instance.codeHexa,
      'slug': instance.slug,
      'created_at': instance.createdAt,
    };
