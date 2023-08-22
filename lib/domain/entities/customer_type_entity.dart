import 'package:pos_application_mobile/domain/entities/entity.dart';

class CustomerTypeEntity extends Entity {
  final String? id;
  final String? name;
  final String? description;
  final String? createdAt;

  CustomerTypeEntity({
    this.id,
    this.createdAt,
    this.description,
    this.name
  });


  @override
  CustomerTypeEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? createdAt,
  }) {
    return CustomerTypeEntity(
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name
    );
  }

  @override
  List<Object?> get props => [
    id, name, description, createdAt
  ];
}