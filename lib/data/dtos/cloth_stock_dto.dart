import 'package:pos_application_mobile/data/dtos/cloth_color_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/size_dto.dart';

part 'cloth_stock.g.dart';

@JsonSerializable()
class ClothStockDTO implements DTO {
  
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "created_by")
  late String? createdBy;

  @JsonKey(name: "stock")
  late int? stock;

  @JsonKey(name: "min_stock")
  late int? minStock;

  @JsonKey(name: "created_at")
  late String? createdAt;

  @JsonKey(name: "updated_at")
  late String? updatedAt;

  @JsonKey(name: "size")
  late SizeDTO? size;

  @JsonKey(name: "cloth_color")
  late ClothColorDTO? clothColor;

  ClothStockDTO({
    this.clothColor,
    this.createdAt,
    this.createdBy,
    this.id,
    this.minStock,
    this.size,
    this.stock,
    this.updatedAt
  });

  factory ClothStockDTO.fromJson(Map<String, dynamic> json) {
    return _$ClothStockDTOFromJson(json);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return _$ClothStockDTOToJson(this);
  }

}