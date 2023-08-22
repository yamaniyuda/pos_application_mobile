import 'package:pos_application_mobile/domain/entities/entity.dart';

class RegencyEntity extends Entity {
  final String? id;
  final String? name;

  RegencyEntity({
    this.id,
    this.name
  });
  
  @override
  RegencyEntity copyWith({
    String? id,
    String? name
  }) {
    return RegencyEntity(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }
  
  @override
  List<Object?> get props => [
    id, name
  ];
}