import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/customer_type_dto.dart';
import 'package:pos_application_mobile/data/dtos/district_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:pos_application_mobile/data/dtos/provincy_dto.dart';
import 'package:pos_application_mobile/data/dtos/regency_dto.dart';
import 'package:pos_application_mobile/data/dtos/village_dto.dart';

part 'customer_dto.g.dart';

@JsonSerializable()
class CustomerDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "customer_category_id")
  late String? customerCategoryId;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "email")
  late String? email;

  @JsonKey(name: "address")
  late String? address;

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

  @JsonKey(name: "customer_category")
  late CustomerTypeDTO? customerType;

  @JsonKey(name: "province")
  late ProvincyDTO? province;

  @JsonKey(name: "regency")
  late RegencyDTO? regency;

  @JsonKey(name: "district")
  late DistrictDTO? district;

  @JsonKey(name: "village")
  late VillageDTO? village;

  @JsonKey(name: "created_at")
  late String? createdAt;

  CustomerDTO({
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
    this.villageId,
    this.district,
    this.province,
    this.regency,
    this.village,
    this.customerType
  });

  factory CustomerDTO.fromJson(Map<String, dynamic> json) {
    return _$CustomerDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$CustomerDTOToJson(this);
  }
}