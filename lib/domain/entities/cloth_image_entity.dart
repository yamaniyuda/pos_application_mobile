import 'package:pos_application_mobile/domain/entities/entity.dart';

class ClothImageEntity extends Entity {
  final String? id;
  final String? image;
  final String? createdAt;

  ClothImageEntity({
    this.createdAt,
    this.id,
    this.image
  });
  
  @override
  ClothImageEntity copyWith({
    String? id,
    String? image,
    String? createdAt
  }) {
    return ClothImageEntity(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      image: image ?? this.image
    );
  }
  
  @override
  List<Object?> get props => [ createdAt, id, image ];
}