import 'package:pos_application_mobile/domain/entities/entity.dart';

class DistrictEntity extends Entity {
  final String? id;
  final String? name;
  final String? districtId;

  DistrictEntity({
    this.id,
    this.name,
    this.districtId
  });
  
  @override
  DistrictEntity copyWith({
    String? id,
    String? name,
    String? districtId
  }) {
    return DistrictEntity(
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