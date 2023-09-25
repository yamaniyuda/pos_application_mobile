
import 'package:pos_application_mobile/domain/entities/cloth_size_price_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';

class ClothSizeEntity extends Entity {
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  int? stock;
  final String? createdAt;
  final SizeEntity? size;
  final List<ClothSizePriceEntity>? clothSizePrices;
  final ClothSizePriceEntity? price;

  ClothSizeEntity({
    this.clothSizePrices,
    this.createdAt,
    this.createdBy,
    this.id,
    this.size,
    this.stock,
    this.price,
    this.updatedBy
  });
  
  @override
  ClothSizeEntity copyWith({
    String? id,
    String? createdBy,
    String? updatedBy,
    int? stock,
    String? createdAt,
    SizeEntity? size,
    ClothSizePriceEntity? price,
    List<ClothSizePriceEntity>? clothSizePrices
  }) {
    return ClothSizeEntity(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      clothSizePrices: clothSizePrices ?? this.clothSizePrices,
      size: size ?? this.size,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      updatedBy: updatedBy ?? this.updatedBy
    );
  }
  
  @override
  List<Object?> get props => [id, createdBy, updatedBy, stock, createdAt, clothSizePrices];
  
  set setStock(int stock) {
    this.stock = stock;
  }
}