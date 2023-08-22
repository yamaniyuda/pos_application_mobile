import 'package:pos_application_mobile/domain/entities/entity.dart';

class ClothCategoryEntity extends Entity {
  final String? id;
  final String? name;
  final String? description;
  final String? createdAt;

  ClothCategoryEntity({
    this.id,
    this.name,
    this.description,
    this.createdAt
  });
  
  @override
  ClothCategoryEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? createdAt
  }) {
    return ClothCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt
    );
  }
  
  @override
  List<Object?> get props => [
    id, name, description, createdAt
  ];
}