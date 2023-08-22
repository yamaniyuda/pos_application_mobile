import 'package:pos_application_mobile/domain/entities/entity.dart';

class VillageEntity extends Entity {
  final String? id;
  final String? name;

  VillageEntity({
    this.id,
    this.name
  });
  
  @override
  VillageEntity copyWith({
    String? id,
    String? name
  }) {
    return VillageEntity(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }
  
  @override
  List<Object?> get props => [
    id, name
  ];
}