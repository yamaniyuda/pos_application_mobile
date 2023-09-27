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
      id: json['id'] as String?,
      size: json['size'] == null
          ? null
          : SizeDTO.fromJson(json['size'] as Map<String, dynamic>),
      price: json['price'] == null
          ? null
          : ClothSizePriceDTO.fromJson(json['price'] as Map<String, dynamic>),
      stock: json['stock'] as int?,
    );

Map<String, dynamic> _$ClothSizeDTOToJson(ClothSizeDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stock': instance.stock,
      'created_at': instance.createdAt,
      'size': instance.size,
      'cloth_size_prices': instance.clothSizePrices,
      'price': instance.price,
    };
