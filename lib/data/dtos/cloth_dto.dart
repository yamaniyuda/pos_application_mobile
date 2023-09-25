import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_categoty_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_color_dto.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:pos_application_mobile/data/dtos/updated_by_dto.dart';

part 'cloth_dto.g.dart';

@JsonSerializable()
class ClothDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "created_by")
  late dynamic createdBy;

  @JsonKey(name: "updated_by")
  late UpdatedByDTO? updatedBy;

  @JsonKey(name: "status")
  late bool? status;

  @JsonKey(name: "cloth_category")
  late ClothCategoryDTO? clothCategory;

  @JsonKey(name: "cloth_colors")
  late List<ClothColorDTO>? clothColors;

  @JsonKey(name: "created_at")
  late String? createdAt;

  ClothDTO({
    this.clothCategory,
    this.clothColors,
    this.createdAt,
    this.createdBy,
    this.id,
    this.status,
    this.updatedBy,
  });

  factory ClothDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$ClothDTOToJson(this);
  }  
}