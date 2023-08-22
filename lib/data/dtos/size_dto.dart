import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'size_dto.g.dart';

@JsonSerializable()
class SizeDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "is_active")
  late int? isActive;

  @JsonKey(name: "description")
  late String? description;

  @JsonKey(name: "slug")
  late String? slug;

  @JsonKey(name: "created_at")
  late String? createdAt;

  SizeDTO({
    this.id,
    this.name,
    this.isActive,
    this.description,
    this.slug,
    this.createdAt
  });

  factory SizeDTO.fromJson(Map<String, dynamic> json) {
    return _$SizeDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$SizeDTOToJson(this);
  }
}