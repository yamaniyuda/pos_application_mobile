import 'package:pos_application_mobile/domain/entities/entity.dart';

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
    this.regencyId,
    this.villageId
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
    String? createdAt
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
      villageId: villageId ?? this.villageId
    );
  }
  
  @override
  List<Object?> get props => [
    id, customerCategoryId, name, email, address, phoneNumber, provinceId, regencyId, districtId, villageId, createdAt
  ];

}