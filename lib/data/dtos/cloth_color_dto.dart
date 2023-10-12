import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_size_dto.dart';
import 'package:pos_application_mobile/data/dtos/color_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'cloth_color_dto.g.dart';

@JsonSerializable()
class ClothColorDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  // @JsonKey(name: "created_by")
  // late String? createdBy;

  // @JsonKey(name: "updated_by")
  // late String? updatedBy;

  @JsonKey(name: "sku")
  late String? sku;

  @JsonKey(name: "path_photo")
  late String? pathPhoto;

  @JsonKey(name: "color")
  late ColorDTO? color;

  @JsonKey(name: "cloth_sizes")
  late List<ClothSizeDTO>? clothSizes;

  @JsonKey(name: "created_at")
  late String? createdAt;

  @JsonKey(name: "cloth")
  late ClothDTO? cloth;

  ClothColorDTO({
    this.id,
    this.clothSizes,
    this.color,
    this.createdAt,
    // this.createdBy,
    this.pathPhoto,
    this.sku,
    this.cloth
    // this.updatedBy
  });

  factory ClothColorDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothColorDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$ClothColorDTOToJson(this);
  }
}