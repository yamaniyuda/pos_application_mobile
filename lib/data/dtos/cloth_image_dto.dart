import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'cloth_image_dto.g.dart';

@JsonSerializable()
class ClothImageDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "image")
  late String? image;

  @JsonKey(name: "created_at")
  late String? createdAt;

  ClothImageDTO({
    this.createdAt,
    this.id,
    this.image
  });

  factory ClothImageDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothImageDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClothImageDTOToJson(this);
  }
}