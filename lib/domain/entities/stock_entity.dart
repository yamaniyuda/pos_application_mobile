import 'package:pos_application_mobile/domain/entities/cloth_stock_entity.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';

class StockEntity extends Entity {
  final String? id;
  final CreatedByEntity? createdBy;
  final String? referralId;
  final String? referral;
  final int? previousStock;
  final int? stockIn;
  final int? stockOut;
  final int? currentStock;
  final String? note;
  final String? createdAt;
  final String? updatedAt;
  final ClothStockEntity? clothStock;

  StockEntity({
    this.clothStock,
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
    this.updatedAt
  });
  
  @override
  Entity copyWith({
    String? id,
    CreatedByEntity? createdBy,
    String? referralId,
    String? referral,
    int? previousStock,
    int? stockIn,
    int? stockOut,
    int? currentStock,
    String? note,
    String? createdAt,
    String? updatedAt,
    ClothStockEntity? clothStock,
  }) {
    return StockEntity(
      clothStock: clothStock ?? this.clothStock,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      currentStock: currentStock ?? this.currentStock,
      id: id ?? this.id,
      note: note ?? this.note,
      previousStock: previousStock ?? this.previousStock,
      referral: referral ?? this.referral,
      referralId: referralId ?? this.referralId,
      stockIn: stockIn ?? this.stockIn,
      stockOut: stockOut ?? this.stockOut,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }
  
  @override
  List<Object?> get props => [
    clothStock,
    createdAt,
    createdBy,
    currentStock,
    id,
    note,
    previousStock,
    referral,
    referralId,
    stockIn,
    stockOut,
    updatedAt
  ];

}