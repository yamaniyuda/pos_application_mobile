// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegencyDTO _$RegencyDTOFromJson(Map<String, dynamic> json) => RegencyDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      provinceId: json['province_id'] as String?,
    );

Map<String, dynamic> _$RegencyDTOToJson(RegencyDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province_id': instance.provinceId,
    };
