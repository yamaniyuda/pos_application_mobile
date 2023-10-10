import 'package:pos_application_mobile/data/dtos/cloth_stock_dto.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';


part 'stock_dto.g.dart'

@JsonSerializable()
class StockDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "created_by")
  late CreatedByDTO? createdBy;

  @JsonKey(name: "referral_id")
  late String? referralId;

  @JsonKey(name: "referral")
  late String? referral;

  @JsonKey(name: "previous_stock")
  late int? previousStock;

  @JsonKey(name: "stock_in")
  late int? stockIn;

  @JsonKey(name: "stock_out")
  late int? stockOut;

  @JsonKey(name: "current_stock")
  late int? currentStock;

  @JsonKey(name: "note")
  late String? note;

  @JsonKey(name: "created_at")
  late String? createdAt;

  @JsonKey(name: "updated_at")
  late String? updatedAt;

  @JsonKey(name: "cloth_stock")
  late ClothStockDTO? clothStock;

  StockDTO({
    this.createdAt,
    this.createdBy,
    this.currentStock,
    this.id,
    this.note,
    this.previousStock,
    this.referral,
    this.referralId,
    this.stockIn,
    this.stockOut,
    this.updatedAt,
    this.clothStock
  });

  factory StockDTO.fromJson(Map<String, dynamic> json) {
    return _$StockDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$StockDTOToJson(this);
  }
  
}