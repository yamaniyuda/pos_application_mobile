import 'package:pos_application_mobile/domain/entities/entity.dart';

class DistrictEntity extends Entity {
  final String? id;
  final String? name;

  DistrictEntity({
    this.id,
    this.name
  });
  
  @override
  DistrictEntity copyWith({
    String? id,
    String? name
  }) {
    return DistrictEntity(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }
  
  @override
  List<Object?> get props => [
    id, name
  ];
}