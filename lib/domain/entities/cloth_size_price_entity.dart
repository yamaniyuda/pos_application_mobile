import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';

class ClothSizePriceEntity extends Entity {
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  final int? price;
  final String? createdAt;
  final ClothPriceTypeEntity? clothPriceType;

  ClothSizePriceEntity({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.price,
    this.createdAt,
    this.clothPriceType
  });
  
  @override
  ClothSizePriceEntity copyWith({
    String? id,
    String? createdBy,
    String? updatedBy,
    int? price,
    String? createdAt,
    ClothPriceTypeEntity? clothPriceType
  }) {
    return ClothSizePriceEntity(
      id: id ?? this.id,
      clothPriceType: clothPriceType ?? this.clothPriceType,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      price: price ?? this.price,
      updatedBy: updatedBy ?? this.updatedBy
    );
  }
  
  @override
  List<Object?> get props => [id, createdBy, updatedBy, price, createdAt, clothPriceType];
}