// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_size_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothSizeDTO _$ClothSizeDTOFromJson(Map<String, dynamic> json) => ClothSizeDTO(
      clothSizePrices: (json['cloth_size_prices'] as List<dynamic>?)
          ?.map((e) => ClothSizePriceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] as String?,
      id: json['id'] as String?,
      size: json['size'] == null
          ? null
          : SizeDTO.fromJson(json['size'] as Map<String, dynamic>),
      stock: json['stock'] as int?,
      updatedBy: json['updated_by'] as String?,
    );

Map<String, dynamic> _$ClothSizeDTOToJson(ClothSizeDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'stock': instance.stock,
      'created_at': instance.createdAt,
      'size': instance.size,
      'cloth_size_prices': instance.clothSizePrices,
    };
