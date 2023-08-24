import 'package:pos_application_mobile/domain/entities/entity.dart';

class RegencyEntity extends Entity {
  final String? id;
  final String? name;
  final String? provinceId;

  RegencyEntity({
    this.id,
    this.name,
    this.provinceId
  });
  
  @override
  RegencyEntity copyWith({
    String? id,
    String? name,
    String? provinceId
  }) {
    return RegencyEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      provinceId:  provinceId ?? this.provinceId
    );
  }
  
  @override
  List<Object?> get props => [
    id, name, provinceId
  ];
}