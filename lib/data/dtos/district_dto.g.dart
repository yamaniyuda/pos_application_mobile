// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictDTO _$DistrictDTOFromJson(Map<String, dynamic> json) => DistrictDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      regencyId: json['regency_id'] as String?,
    );

Map<String, dynamic> _$DistrictDTOToJson(DistrictDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'regency_id': instance.regencyId,
    };
