import 'package:pos_application_mobile/domain/entities/entity.dart';

class VillageEntity extends Entity {
  final String? id;
  final String? name;
  final String? districtId;

  VillageEntity({
    this.id,
    this.name,
    this.districtId
  });
  
  @override
  VillageEntity copyWith({
    String? id,
    String? name,
    String? districtId
  }) {
    return VillageEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      districtId: districtId ?? this.districtId
    );
  }
  
  @override
  List<Object?> get props => [
    id, name, districtId
  ];
}