import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/user_dto.dart';
import 'package:pos_application_mobile/data/payloads/user_payload.dart';

class UserDataSource extends RemoteDataSource {

  /// Fetches user data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving user data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [UserDTO] objects representing the fetched user data.
  ///
  Future<List<UserDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<UserDTO> response = await dioClient.getRequest(
      "api/users",
      converter: (data) => List<UserDTO>.from(
        data["data"].map((d) => UserDTO.fromJson(d)),
      ),
      queryParameters: queryParameters,
    );

    return response;
  }

  /// Fetch data from a remote API.
  /// 
  /// The `fetchDetailData` function is responsible for retrieving use detail data form a API.
  /// It parse the JSON response and converts it into Dart data objekct.
  /// 
  /// Paramets:
  /// - `id`: A string id or unique identifier to be include in url path.
  /// - `queryParametes`: A optonal map of query parameters to be include in the requrest.
  /// 
  /// Returns:
  /// A [UserDTO] object representing the fetched detail user data.
  /// 
  Future<UserDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final UserDTO response = await dioClient.getRequest(
      "api/users/$id",
      converter: (data) => UserDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores user data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/users"
  /// in order to store user data. It takes a [payload] parameter containing
  /// the user data to be stored. The function returns a [UserDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [UserDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final UserPayload payload = UserPayload(/* ... */);
  /// final UserDTO storedUser = await storeData(payload);
  /// print("User stored: ${storedUser.username}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<UserDTO>] representing the stored user data.
  Future<UserDTO> storeData(UserPaylaod payload) async {
    final UserDTO response = await dioClient.postRequest(
      "api/users", 
      converter: (data) => UserDTO.fromJson(data), 
      payload: payload
    );
    return response;
  }

  /// Updates user data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/users"
  /// in order to update user data. It takes a [payload] parameter containing
  /// the updated user data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [UserDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final UserPayload updatedPayload = UserPayload(/* ... */);
  /// final UserDTO updatedUser = await updateData(updatedPayload);
  /// print("User updated: ${updatedUser.username}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<UserDTO>] representing the updated user data.
  Future<UserDTO> updateData(String id, UserPaylaod paylaod) async {
    final UserDTO response = await dioClient.patchRequest(
      "api/users/$id", 
      converter: (data) => UserDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes user data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/users"
  /// to delete user data associated with the given [id].
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that can be used to convert the raw response data from the API; in this
  /// case, it's set to `(data) => null` since no response data is expected.
  ///
  /// Example usage:
  /// ```dart
  /// final String userIdToDelete = "12345";
  /// await deleteData(userIdToDelete);
  /// print("User with ID $userIdToDelete deleted successfully.");
  /// ```
  ///
  /// Throws an error if the network request fails.
  ///
  /// Parameters:
  /// - [id]: The identifier of the user to be deleted.
  ///
  /// Returns a [Future<void>] indicating the completion of the delete operation.
  Future<void> deleteData(String id) async {
    await dioClient.deleteRequest(
      "api/users", 
      converter: (data) => null,
      id: id
    );
  }
}