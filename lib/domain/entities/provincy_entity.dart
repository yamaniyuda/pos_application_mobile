import 'package:pos_application_mobile/domain/entities/entity.dart';

class ProvincyEntity extends Entity {
  final String? id;
  final String? name;

  ProvincyEntity({
    this.id,
    this.name
  });
  
  @override
  ProvincyEntity copyWith({
    String? id,
    String? name
  }) {
    return ProvincyEntity(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }
  
  @override
  List<Object?> get props => [
    id, name
  ];
}