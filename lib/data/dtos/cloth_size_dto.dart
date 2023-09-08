import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_size_price_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:pos_application_mobile/data/dtos/size_dto.dart';

part 'cloth_size_dto.g.dart';

@JsonSerializable()
class ClothSizeDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "created_by")
  late String? createdBy;

  @JsonKey(name: "updated_by")
  late String? updatedBy;

  @JsonKey(name: "stock")
  late int? stock;

  @JsonKey(name: "created_at")
  late String? createdAt;

  @JsonKey(name: "size")
  late SizeDTO? size;

  @JsonKey(name: "cloth_size_prices")
  late List<ClothSizePriceDTO>? clothSizePrices;

  ClothSizeDTO({
    this.clothSizePrices,
    this.createdAt,
    this.createdBy,
    this.id,
    this.size,
    this.stock,
    this.updatedBy
  });
  
  factory ClothSizeDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothSizeDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClothSizeDTOToJson(this);
  }
}