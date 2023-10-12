
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_size_entity.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';

class ClothColorEntity extends Entity {
  final String? id;
  // final String? createdBy;
  // final String? updatedBy;
  final String? sku;
  final String? pathPhoto;
  final ColorEntity? color;
  final List<ClothSizeEntity>? clothSizes;
  final String? createdAt;
  final ClothEntity? cloth;

  ClothColorEntity({
    this.id,
    this.clothSizes,
    this.color,
    this.createdAt,
    // this.createdBy,
    this.pathPhoto,
    this.sku,
    this.cloth,
    // this.updatedBy
  });
  
  @override
  ClothColorEntity copyWith({
    String? id,
    String? createdBy,
    String? updatedBy,
    String? sku,
    String? pathPhoto,
    ColorEntity? color,
    List<ClothSizeEntity>? clothSizes,
    String? createdAt,
    ClothEntity? cloth
  }) {
    return ClothColorEntity(
      id: id ?? this.id,
      // createdBy: createdBy ?? this.createdBy,
      // updatedBy: updatedBy ?? this.updatedBy,
      sku: sku ?? this.sku,
      pathPhoto: pathPhoto ?? this.pathPhoto,
      color: color ?? this.color,
      clothSizes: clothSizes ?? this.clothSizes,
      createdAt: createdAt ?? this.createdAt,
      cloth: cloth ?? this.cloth
    );
  }
  
  @override
  List<Object?> get props => [id, createdAt, sku, pathPhoto, color, clothSizes, cloth];
}