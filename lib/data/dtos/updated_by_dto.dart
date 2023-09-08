import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part "updated_by_dto.g.dart";

@JsonSerializable()
class UpdatedByDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "email")
  late String? email;

  UpdatedByDTO({ this.id, this.name, this.email });

  factory UpdatedByDTO.fromJson(Map<String, dynamic> json) {
    return _$UpdatedByDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UpdatedByDTOToJson(this);
  }
}