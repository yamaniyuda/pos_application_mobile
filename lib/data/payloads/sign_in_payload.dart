import 'package:pos_application_mobile/data/payloads/payload.dart';

class SignInPayload extends Payload {
  final String username;
  final String password;

  SignInPayload({
    required this.username,
    required this.password
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password
    };
  }
}