import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/size_dto.dart';
import 'package:pos_application_mobile/data/payloads/size_payload.dart';

class SizeDataSource extends RemoteDataSource {

  /// Fetches size data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving size data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [SizeDTO] objects representing the fetched size data.
  ///
  Future<List<SizeDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<SizeDTO> response = await dioClient.getRequest(
      "api/sizes",
      converter: (data) => List<SizeDTO>.from(
        data["data"].map((d) => SizeDTO.fromJson(d)),
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
  /// A [SizeDTO] object representing the fetched detail size data.
  /// 
  Future<SizeDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final SizeDTO response = await dioClient.getRequest(
      "api/sizes/$id",
      converter: (data) => SizeDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores size data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/sizes"
  /// in order to store size data. It takes a [payload] parameter containing
  /// the size data to be stored. The function returns a [SizeDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [SizeDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final sizePayload payload = sizePayload(/* ... */);
  /// final SizeDTO storedsize = await storeData(payload);
  /// print("size stored: ${storedsize.sizename}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<SizeDTO>] representing the stored size data.
  Future<SizeDTO> storeData(SizePayload payload) async {
    final SizeDTO response = await dioClient.postRequest(
      "api/sizes", 
      converter: (data) => SizeDTO.fromJson(data), 
      payload: payload
    );
    return response;
  }

  /// Updates size data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/sizes"
  /// in order to update size data. It takes a [payload] parameter containing
  /// the updated size data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [SizeDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final sizePayload updatedPayload = sizePayload(/* ... */);
  /// final SizeDTO updatedsize = await updateData(updatedPayload);
  /// print("size updated: ${updatedsize.sizename}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<SizeDTO>] representing the updated size data.
  Future<SizeDTO> updateData(String id, SizePayload paylaod) async {
    final SizeDTO response = await dioClient.patchRequest(
      "api/sizes/$id", 
      converter: (data) => SizeDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes size data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/sizes"
  /// to delete size data associated with the given [id].
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that can be used to convert the raw response data from the API; in this
  /// case, it's set to `(data) => null` since no response data is expected.
  ///
  /// Example usage:
  /// ```dart
  /// final String sizeIdToDelete = "12345";
  /// await deleteData(sizeIdToDelete);
  /// print("size with ID $sizeIdToDelete deleted successfully.");
  /// ```
  ///
  /// Throws an error if the network request fails.
  ///
  /// Parameters:
  /// - [id]: The identifier of the size to be deleted.
  ///
  /// Returns a [Future<void>] indicating the completion of the delete operation.
  Future<void> deleteData(String id) async {
    await dioClient.deleteRequest(
      "api/sizes", 
      converter: (data) => null,
      id: id
    );
  }
}