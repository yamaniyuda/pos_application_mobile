import 'package:pos_application_mobile/domain/entities/entity.dart';

class AuthEntity extends Entity {
  final String? token;
  final int? expiresIn;
  final String? accessToken;
  final String? refreshToken;

  AuthEntity({
    this.refreshToken,
    this.expiresIn,
    this.accessToken,
    this.token
  });

  @override
  List<Object?> get props => [
    token, expiresIn, accessToken, refreshToken
  ];

  @override
  AuthEntity copyWith({
    String? token,
    int? expiresIn,
    String? accessToken,
    String? refreshToken
  }) {
    return AuthEntity(
      token: token ?? this.token,
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
      refreshToken: refreshToken ?? this.refreshToken
    );
  }
}