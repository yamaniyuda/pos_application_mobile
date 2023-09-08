import 'package:pos_application_mobile/domain/entities/entity.dart';

class CreatedByEntity extends Entity {
  final String? id;
  final String? name;
  final String? email;

  CreatedByEntity({
    this.id,
    this.name,
    this.email
  });

  @override
  CreatedByEntity copyWith({
    String? id,
    String? name,
    String? email
  }) {
    return CreatedByEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email
    );
  }

  @override
  List<Object?> get props => [id, name, email];

}