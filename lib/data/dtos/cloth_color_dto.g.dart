// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_color_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothColorDTO _$ClothColorDTOFromJson(Map<String, dynamic> json) =>
    ClothColorDTO(
      id: json['id'] as String?,
      clothSizes: (json['cloth_sizes'] as List<dynamic>?)
          ?.map((e) => ClothSizeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      color: json['color'] == null
          ? null
          : ColorDTO.fromJson(json['color'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] as String?,
      pathPhoto: json['path_photo'] as String?,
      sku: json['sku'] as String?,
      updatedBy: json['updated_by'] as String?,
    );

Map<String, dynamic> _$ClothColorDTOToJson(ClothColorDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'sku': instance.sku,
      'path_photo': instance.pathPhoto,
      'color': instance.color,
      'cloth_sizes': instance.clothSizes,
      'created_at': instance.createdAt,
    };
