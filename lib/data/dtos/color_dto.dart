import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'color_dto.g.dart';

@JsonSerializable()
class ColorDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "is_active")
  late int? isActive;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "description")
  late String? description;

  @JsonKey(name: "code_hexa")
  late String? codeHexa;

  @JsonKey(name: "slug")
  late String? slug;

  @JsonKey(name: "created_at")
  late String? createdAt;

  ColorDTO({
    this.name,
    this.id,
    this.createdAt,
    this.codeHexa,
    this.description,
    this.isActive,
    this.slug
  });

  factory ColorDTO.fromJson(Map<String, dynamic> json) {
    return _$ColorDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ColorDTOToJson(this);
  }
}