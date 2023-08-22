import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'village_dto.g.dart';

@JsonSerializable()
class VillageDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  VillageDTO({
    this.id,
    this.name
  });
  
  factory VillageDTO.fromJson(Map<String, dynamic> json) {
    return _$VillageDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$VillageDTOToJson(this);
  }
}