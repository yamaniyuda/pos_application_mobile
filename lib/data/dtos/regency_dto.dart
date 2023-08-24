import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'regency_dto.g.dart';

@JsonSerializable()
class RegencyDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "province_id")
  late String? provinceId;

  RegencyDTO({
    this.id,
    this.name,
    this.provinceId
  });
  
  factory RegencyDTO.fromJson(Map<String, dynamic> json) {
    return _$RegencyDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$RegencyDTOToJson(this);
  }
}