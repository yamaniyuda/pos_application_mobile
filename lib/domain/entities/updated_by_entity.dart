// ignore_for_file: must_be_immutable

import 'package:pos_application_mobile/domain/entities/entity.dart';

class UpdatedByEntity extends Entity {
  final String? id;
  final String? name;
  final String? email;

  UpdatedByEntity({ this.id, this.name, this.email });
  
  @override
  UpdatedByEntity copyWith({
    String? id,
    String? name,
    String? email
  }) {
    return UpdatedByEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email
    );
  }
  
  @override
  List<Object?> get props => [id, name, email];
}