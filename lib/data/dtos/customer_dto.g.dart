// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDTO _$CustomerDTOFromJson(Map<String, dynamic> json) => CustomerDTO(
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      customerCategoryId: json['customer_category_id'] as String?,
      districtId: json['district_id'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      provinceId: json['province_id'] as String?,
      regencyId: json['regency_id'] as String?,
      villageId: json['village_id'] as String?,
      district: json['district'] == null
          ? null
          : DistrictDTO.fromJson(json['district'] as Map<String, dynamic>),
      province: json['province'] == null
          ? null
          : ProvincyDTO.fromJson(json['province'] as Map<String, dynamic>),
      regency: json['regency'] == null
          ? null
          : RegencyDTO.fromJson(json['regency'] as Map<String, dynamic>),
      village: json['village'] == null
          ? null
          : VillageDTO.fromJson(json['village'] as Map<String, dynamic>),
      customerType: json['customer_category'] == null
          ? null
          : CustomerTypeDTO.fromJson(
              json['customer_category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerDTOToJson(CustomerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_category_id': instance.customerCategoryId,
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'phone_number': instance.phoneNumber,
      'province_id': instance.provinceId,
      'regency_id': instance.regencyId,
      'district_id': instance.districtId,
      'village_id': instance.villageId,
      'customer_category': instance.customerType,
      'province': instance.province,
      'regency': instance.regency,
      'district': instance.district,
      'village': instance.village,
      'created_at': instance.createdAt,
    };
