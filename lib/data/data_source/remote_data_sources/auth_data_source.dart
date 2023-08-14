import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/auth_dto.dart';
import 'package:pos_application_mobile/data/dtos/user_dto.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthDataSource extends RemoteDataSource {
  Future<AuthDTO> singIn({ required SignInPayload payload }) async {
    late Map<String, dynamic> payloadData = payload.toJson();
    // await dotenv.load(fileName: ".env");

    payloadData.addAll({
      "client_id": dotenv.env["CLIENT_ID"],
      "client_secret": dotenv.env["CLIENT_SECRET"],
      "grant_type": "password",
      "scope": "*"
    });

    final AuthDTO response = await dioClient.postRequest(
      "oauth/token",
      payload: payloadData,
      converter: (data) => AuthDTO.fromJson(data)
    );

    return response;
  }

  Future<UserDTO> me() async {
    final UserDTO response = await dioClient.getRequest(
      "api/me",
      converter: (data) => UserDTO.fromJson(data["data"])
    );

    return response;
  }
}