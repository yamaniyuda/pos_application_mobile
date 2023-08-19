import 'package:pos_application_mobile/data/payloads/payload.dart';

class UserPaylaod extends Payload {
  final String id;
  final String name;
  final String gender;
  final String email;
  final String password;
  final String role;

  UserPaylaod({
    this.id = '',
    required this.name,
    required this.gender,
    required this.email,
    required  this.password,
    required this.role
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": gender,
      "email": email,
      "password": password,
      "role": role
    };
  }
}