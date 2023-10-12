// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_stock_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothStockDTO _$ClothStockDTOFromJson(Map<String, dynamic> json) =>
    ClothStockDTO(
      clothColor: json['cloth_color'] == null
          ? null
          : ClothColorDTO.fromJson(json['cloth_color'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] as String?,
      id: json['id'] as String?,
      minStock: json['min_stock'] as int?,
      size: json['size'] == null
          ? null
          : SizeDTO.fromJson(json['size'] as Map<String, dynamic>),
      stock: json['stock'] as int?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ClothStockDTOToJson(ClothStockDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'stock': instance.stock,
      'min_stock': instance.minStock,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'size': instance.size,
      'cloth_color': instance.clothColor,
    };
