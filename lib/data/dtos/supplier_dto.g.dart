// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierDTO _$SupplierDTOFromJson(Map<String, dynamic> json) => SupplierDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      provinceId: json['province_id'] as String?,
      regencyId: json['regency_id'] as String?,
      districtId: json['district_id'] as String?,
      villageId: json['village_id'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$SupplierDTOToJson(SupplierDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'province_id': instance.provinceId,
      'regency_id': instance.regencyId,
      'district_id': instance.districtId,
      'village_id': instance.villageId,
      'created_at': instance.createdAt,
    };
