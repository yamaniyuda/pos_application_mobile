import 'package:pos_application_mobile/data/dtos/district_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/provincy_dto.dart';
import 'package:pos_application_mobile/data/dtos/regency_dto.dart';
import 'package:pos_application_mobile/data/dtos/village_dto.dart';

part 'supplier_dto.g.dart';

@JsonSerializable()
class SupplierDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "email")
  late String? email;

  @JsonKey(name: "phone_number")
  late String? phoneNumber;

  @JsonKey(name: "province_id")
  late String? provinceId;

  @JsonKey(name: "regency_id")
  late String? regencyId;

  @JsonKey(name: "district_id")
  late String? districtId;

  @JsonKey(name: "village_id")
  late String? villageId;

  @JsonKey(name: "province")
  late ProvincyDTO? province;

  @JsonKey(name: "regency")
  late RegencyDTO? regency;

  @JsonKey(name: "district")
  late DistrictDTO? district;

  @JsonKey(name: "village")
  late VillageDTO? village;

  @JsonKey(name: "address")
  late String? address;

  @JsonKey(name: "created_at")
  late String? createdAt;

  SupplierDTO({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    this.address,
    this.createdAt,
    this.district,
    this.province,
    this.regency,
    this.village
  });

  factory SupplierDTO.fromJson(Map<String, dynamic> json) {
    return _$SupplierDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$SupplierDTOToJson(this);
  }
}