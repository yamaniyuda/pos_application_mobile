// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_size_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothSizePriceDTO _$ClothSizePriceDTOFromJson(Map<String, dynamic> json) =>
    ClothSizePriceDTO(
      id: json['id'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      price: json['price'] as int?,
      createdAt: json['created_at'] as String?,
      clothPriceType: json['cloth_price_type'] == null
          ? null
          : ClothPriceTypeDTO.fromJson(
              json['cloth_price_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClothSizePriceDTOToJson(ClothSizePriceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'price': instance.price,
      'created_at': instance.createdAt,
      'cloth_price_type': instance.clothPriceType,
    };
