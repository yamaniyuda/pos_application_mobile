
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';
import 'package:pos_application_mobile/domain/entities/updated_by_entity.dart';

class ClothEntity extends Entity {
  final String? id;
  final CreatedByEntity? createdBy;
  final UpdatedByEntity? updatedBy;
  final bool? status;
  final ClothCategoryEntity? clothCategory;
  final List<ClothColorEntity>? clothColors;
  final String? createdAt;

  ClothEntity({
    this.clothCategory,
    this.clothColors,
    this.createdAt,
    this.createdBy,
    this.id,
    this.status,
    this.updatedBy,
  });
  
  @override
  ClothEntity copyWith({
    String? id,
    CreatedByEntity? createdBy,
    UpdatedByEntity? updatedBy,
    bool? status,
    ClothCategoryEntity? clothCategory,
    List<ClothColorEntity>? clothColors,
    String? createdAt,
  }) {
    return ClothEntity(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      clothCategory: clothCategory ?? this.clothCategory,
      clothColors: clothColors ?? this.clothColors,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      updatedBy: updatedBy ?? this.updatedBy
    );
  }
  
  @override
  List<Object?> get props => [id, createdBy, clothCategory, clothColors, createdAt, status, updatedBy];
}