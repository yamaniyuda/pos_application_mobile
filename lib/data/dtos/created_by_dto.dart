import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part "created_by_dto.g.dart";

@JsonSerializable()
class CreatedByDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "email")
  late String? email;

  CreatedByDTO({ this.id, this.name, this.email });

  factory CreatedByDTO.fromJson(Map<String, dynamic> json) {
    return _$CreatedByDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreatedByDTOToJson(this);
  }
}