import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'cloth_price_type_dto.g.dart';

@JsonSerializable()
class ClothPriceTypeDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  // @JsonKey(name: "created_by")
  // late String? createdBy;
  
  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "description")
  late String? description;

  ClothPriceTypeDTO({
    // this.createdBy,
    this.description,
    this.id,
    this.name
  });

  factory ClothPriceTypeDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothPriceTypeDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClothPriceTypeDTOToJson(this);
  }
}