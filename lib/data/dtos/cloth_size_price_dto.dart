import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_price_type_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'cloth_size_price_dto.g.dart';

@JsonSerializable()
class ClothSizePriceDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "created_by")
  late String? createdBy;

  @JsonKey(name: "updated_by")
  late String? updatedBy;

  @JsonKey(name: "price")
  late int? price;

  @JsonKey(name: "created_at")
  late String? createdAt;

  @JsonKey(name: "cloth_price_type")
  late ClothPriceTypeDTO? clothPriceType;

  ClothSizePriceDTO({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.price,
    this.createdAt,
    this.clothPriceType
  });

  factory ClothSizePriceDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothSizePriceDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClothSizePriceDTOToJson(this);
  }
}