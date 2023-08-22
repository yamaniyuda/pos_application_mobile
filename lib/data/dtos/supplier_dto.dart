import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supplier_dto.g.dart';

@JsonSerializable()
class SupplierDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "email")
  late String? email;

  @JsonKey(name: "phone")
  late String? phone;

  @JsonKey(name: "province_id")
  late String? provinceId;

  @JsonKey(name: "regency_id")
  late String? regencyId;

  @JsonKey(name: "district_id")
  late String? districtId;

  @JsonKey(name: "village_id")
  late String? villageId;

  @JsonKey(name: "created_at")
  late String? createdAt;

  SupplierDTO({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    this.createdAt
  });

  factory SupplierDTO.fromJson(Map<String, dynamic> json) {
    return _$SupplierDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$SupplierDTOToJson(this);
  }
}