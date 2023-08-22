import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cloth_categoty_dto.g.dart';

@JsonSerializable()
class ClothCategoryDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "description")
  late String? description;

  @JsonKey(name: "created_at")
  late String? createdAt;

  ClothCategoryDTO({
    this.id,
    this.name,
    this.description,
    this.createdAt
  });

  factory ClothCategoryDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothCategoryDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$ClothCategoryDTOToJson(this);
  }
}