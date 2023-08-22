import 'package:pos_application_mobile/domain/entities/entity.dart';

class SupplierEntity extends Entity {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? provinceId;
  final String? regencyId;
  final String? districtId;
  final String? villageId;
  final String? createdAt;

  SupplierEntity({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    this.createdAt
  });
  
  @override
  SupplierEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? provinceId,
    String? regencyId,
    String? districtId,
    String? villageId,
    String? createdAt
  }) {
    return SupplierEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email:  email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      provinceId: provinceId ?? this.provinceId,
      regencyId: regencyId ?? this.regencyId,
      districtId: districtId ?? this.districtId,
      villageId: villageId ?? this.villageId,
      createdAt: createdAt ?? this.createdAt
    );
  }
  
  @override
  List<Object?> get props => [
    id, name, email, phoneNumber, address, provinceId, regencyId, districtId, villageId, createdAt
  ];
}