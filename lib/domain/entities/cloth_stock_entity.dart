import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';

class ClothStockEntity extends Entity {   
  final String? id;
  final String? createdBy;
  final int? stock;
  final int? minStock;
  final String? createdAt;
  final String? updatedAt;
  final SizeEntity? size;
  final ClothColorEntity? clothColor;

  ClothStockEntity({
    this.clothColor,
    this.createdAt,
    this.createdBy,
    this.id,
    this.minStock,
    this.size,
    this.stock,
    this.updatedAt
  });
  
  @override
  ClothStockEntity copyWith({
    String? id,
    String? createdBy,
    int? stock,
    int? minStock,
    String? createdAt,
    String? updatedAt,
    SizeEntity? size,
    ClothColorEntity? clothColor
  }) {
    return ClothStockEntity(
      clothColor: clothColor ?? this.clothColor,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      id: id ?? this.id,
      minStock: minStock ?? this.minStock,
      size: size ?? this.size,
      stock: stock ?? this.stock,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    createdAt,
    stock,
    minStock,
    createdAt,
    updatedAt,
    size,
    clothColor
  ];
}