import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/entities/district_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';
import 'package:pos_application_mobile/domain/entities/provincy_entity.dart';
import 'package:pos_application_mobile/domain/entities/regency_entity.dart';
import 'package:pos_application_mobile/domain/entities/village_entity.dart';

class CustomerEntity extends Entity {
  final String? id;
  final String? customerCategoryId;
  final String? name;
  final String? email;
  final String? address;
  final String? phoneNumber;
  final String? provinceId;
  final String? regencyId;
  final String? districtId;
  final String? villageId;
  final CustomerTypeEntity? customerType;
  final ProvincyEntity? province;
  final RegencyEntity? regency;
  final DistrictEntity? district;
  final VillageEntity? village;
  final String? createdAt;

  CustomerEntity({
    this.address,
    this.createdAt,
    this.customerCategoryId,
    this.districtId,
    this.email,
    this.id,
    this.name,
    this.phoneNumber,
    this.provinceId,
    this.customerType,
    this.regencyId,
    this.villageId,
    this.district,
    this.province,
    this.regency,
    this.village
  });
  
  @override
  CustomerEntity copyWith({
    String? id,
    String? customerCategoryId,
    String? name,
    String? email,
    String? address,
    String? phoneNumber,
    String? provinceId,
    String? regencyId,
    String? districtId,
    String? villageId,
    String? createdAt,
    CustomerTypeEntity? customerType,
    ProvincyEntity? province,
    RegencyEntity? regency,
    DistrictEntity? district,
    VillageEntity? village
  }) {
    return CustomerEntity(
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      customerCategoryId: customerCategoryId ?? this.customerCategoryId,
      districtId: districtId ?? this.districtId,
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      provinceId: provinceId ?? this.provinceId,
      regencyId: regencyId ?? this.regencyId,
      villageId: villageId ?? this.villageId,
      customerType: customerType ?? this.customerType,
      province: province ?? this.province,
      district: district ?? this.district,
      regency: regency ?? this.regency,
      village: village ?? this.village
    );
  }
  
  @override
  List<Object?> get props => [
    id, 
    customerCategoryId, 
    name, 
    email, 
    address, 
    phoneNumber, 
    customerType,
    provinceId, 
    regencyId, 
    districtId, 
    villageId, 
    createdAt,
    province,
    district,
    regency,
    village
  ];

}