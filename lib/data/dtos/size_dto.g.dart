// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeDTO _$SizeDTOFromJson(Map<String, dynamic> json) => SizeDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      isActive: json['is_active'] as int?,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$SizeDTOToJson(SizeDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_active': instance.isActive,
      'description': instance.description,
      'slug': instance.slug,
      'created_at': instance.createdAt,
    };
