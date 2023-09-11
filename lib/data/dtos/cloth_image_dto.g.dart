// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothImageDTO _$ClothImageDTOFromJson(Map<String, dynamic> json) =>
    ClothImageDTO(
      createdAt: json['created_at'] as String?,
      id: json['id'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ClothImageDTOToJson(ClothImageDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'created_at': instance.createdAt,
    };
