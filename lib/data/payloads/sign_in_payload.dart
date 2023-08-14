import 'package:pos_application_mobile/data/payloads/payload.dart';

class SignInPayload extends Payload {
  final String username;
  final String password;
  final bool? rememberMe;

  SignInPayload({
    required this.username,
    required this.password,
    this.rememberMe
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password
    };
  }
}