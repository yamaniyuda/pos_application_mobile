import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'provincy_dto.g.dart';

@JsonSerializable()
class ProvincyDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  ProvincyDTO({
    this.id,
    this.name
  });
  
  factory ProvincyDTO.fromJson(Map<String, dynamic> json) {
    return _$ProvincyDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ProvincyDTOToJson(this);
  }
}