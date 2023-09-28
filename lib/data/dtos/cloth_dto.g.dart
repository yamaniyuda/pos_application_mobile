// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothDTO _$ClothDTOFromJson(Map<String, dynamic> json) => ClothDTO(
      clothCategory: json['cloth_category'] == null
          ? null
          : ClothCategoryDTO.fromJson(
              json['cloth_category'] as Map<String, dynamic>),
      clothColors: (json['cloth_colors'] as List<dynamic>?)
          ?.map((e) => ClothColorDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] == null
          ? null
          : CreatedByDTO.fromJson(json['created_by'] as Map<String, dynamic>),
      id: json['id'] as String?,
      status: json['status'] as bool?,
      updatedBy: ClothDTO._updatedByFromJson(json['updated_by']),
    );

Map<String, dynamic> _$ClothDTOToJson(ClothDTO instance) => <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'status': instance.status,
      'cloth_category': instance.clothCategory,
      'cloth_colors': instance.clothColors,
      'created_at': instance.createdAt,
    };
