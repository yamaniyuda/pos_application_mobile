import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'district_dto.g.dart';

@JsonSerializable()
class DistrictDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "regency_id")
  late String? regencyId;

  DistrictDTO({
    this.id,
    this.name,
    this.regencyId
  });
  
  factory DistrictDTO.fromJson(Map<String, dynamic> json) {
    return _$DistrictDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DistrictDTOToJson(this);
  }
}