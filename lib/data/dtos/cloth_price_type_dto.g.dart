// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_price_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothPriceTypeDTO _$ClothPriceTypeDTOFromJson(Map<String, dynamic> json) =>
    ClothPriceTypeDTO(
      description: json['description'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ClothPriceTypeDTOToJson(ClothPriceTypeDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
