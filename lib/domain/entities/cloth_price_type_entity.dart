// import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';

class ClothPriceTypeEntity extends Entity {
  final String? id;
  final String? name;
  final String? description;
  final String? createdBy;

  ClothPriceTypeEntity({
    this.id,
    this.name,
    this.description,
    this.createdBy
  });

  @override
  ClothPriceTypeEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? createdBy
  }) {
    return ClothPriceTypeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy
    );
  }

  @override
  List<Object?> get props => [id, name, description, createdBy];

}