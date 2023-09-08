import 'package:pos_application_mobile/domain/entities/entity.dart';


class ColorEntity extends Entity {
  final String? id;
  final int? isActive;
  final String? name;
  final String? description;
  final String? slug;
  final String? codeHexa;
  final String? createdAt;

  ColorEntity({
    this.slug,
    this.isActive,
    this.description,
    this.createdAt,
    this.codeHexa,
    this.id,
    this.name
  });

  @override
  List<Object?> get props => [
    id, slug, isActive, description, name
  ];

  @override
  ColorEntity copyWith({
    String? id,
    int? isActive,
    String? name,
    String? description,
    String? slug,
    String? createdAt,
  }) {
    return ColorEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      slug: slug ?? this.slug,
    );
  }
}