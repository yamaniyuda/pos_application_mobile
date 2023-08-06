import 'package:pos_application_mobile/domain/entities/entity.dart';

class UserEntity extends Entity {
  final String? id;
  final String? role;
  final String? email;
  final String? phoneNumber;
  final String? name;
  final String? gender;

  UserEntity({
    this.name,
    this.id,
    this.email,
    this.phoneNumber,
    this.gender,
    this.role,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id, name, email, phoneNumber, gender, role
  ];

  @override
  Entity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? role
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      role: role ?? this.role
    );
  }
}