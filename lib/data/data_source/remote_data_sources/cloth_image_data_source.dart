// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_image_dto.dart';
import 'package:pos_application_mobile/data/payloads/cloth_image_payload.dart';

class ClothImageDataSource extends RemoteDataSource {

  /// Fetches cloth price type data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving customer data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [ClothImageDTO] objects representing the fetched customer data.
  ///
  Future<List<ClothImageDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothImageDTO> response = await dioClient.getRequest(
      "api/cloth-photos",
      converter: (data) => List<ClothImageDTO>.from(
        data["data"].map((d) => ClothImageDTO.fromJson(d)),
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
  /// A [ClothImageDTO] object representing the fetched detail customer data.
  /// 
  Future<ClothImageDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final ClothImageDTO response = await dioClient.getRequest(
      "api/cloth-photos/$id",
      converter: (data) => ClothImageDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores customer data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/cloth-photos"
  /// in order to store customer data. It takes a [payload] parameter containing
  /// the customer data to be stored. The function returns a [ClothImageDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [ClothImageDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload payload = customerPayload(/* ... */);
  /// final ClothImageDTO customer = await storeData(payload);
  /// print("customer stored: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothImageDTO>] representing the stored customer data.
  Future<ClothImageDTO> storeData(ClothImagePayload payload) async {
    String fileName = payload.image.path.split('/').last;
    final FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(payload.image.path, filename: fileName),
      "cloth_id": payload.clothId
    });

    final ClothImageDTO respone = await dioClient.postRequest(
      "api/cloth-photos", 
      converter: (data) => ClothImageDTO.fromJson(data), 
      payload: formData
    );

    return respone;
  }

  /// Updates customer data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/cloth-photos"
  /// in order to update customer data. It takes a [payload] parameter containing
  /// the updated customer data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [ClothImageDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload updatedPayload = customerPayload(/* ... */);
  /// final ClothImageDTO customer = await updateData(updatedPayload);
  /// print("customer updated: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothImageDTO>] representing the updated customer data.
  Future<ClothImageDTO> updateData(String id, ClothImagePayload paylaod) async {
    final ClothImageDTO response = await dioClient.patchRequest(
      "api/cloth-photos/$id", 
      converter: (data) => ClothImageDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes customer data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/cloth-photos"
  /// to delete customer data associated with the given [id].
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that can be used to convert the raw response data from the API; in this
  /// case, it's set to `(data) => null` since no response data is expected.
  ///
  /// Example usage:
  /// ```dart
  /// final String customerIdToDelete = "12345";
  /// await deleteData(customerIdToDelete);
  /// print("customer with ID $customerIdToDelete deleted successfully.");
  /// ```
  ///
  /// Throws an error if the network request fails.
  ///
  /// Parameters:
  /// - [id]: The identifier of the customer to be deleted.
  ///
  /// Returns a [Future<void>] indicating the completion of the delete operation.
  Future<void> deleteData(String id) async {
    await dioClient.deleteRequest(
      "api/cloth-photos", 
      converter: (data) => null,
      id: id
    );
  }
}