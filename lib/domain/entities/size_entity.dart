import 'package:pos_application_mobile/domain/entities/entity.dart';

class SizeEntity extends Entity {
  final String? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? createdAt;

  SizeEntity({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.createdAt
  });
  
  @override
  SizeEntity copyWith({
    String? id,
    String? name,
    String? slug,
    String? description,
    String? createdAt
  }) {
    return SizeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt
    );
  }
  
  @override
  List<Object?> get props => [
    id, name, description, createdAt
  ];
}