import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_price_type_dto.dart';
import 'package:pos_application_mobile/data/payloads/cloth_price_type_payload.dart';

class ClothPriceTypeDataDataSource extends RemoteDataSource {

  /// Fetches cloth price type data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving customer data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [ClothPriceTypeDTO] objects representing the fetched customer data.
  ///
  Future<List<ClothPriceTypeDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothPriceTypeDTO> response = await dioClient.getRequest(
      "api/cloth-price-types",
      converter: (data) => List<ClothPriceTypeDTO>.from(
        data["data"].map((d) => ClothPriceTypeDTO.fromJson(d)),
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
  /// A [ClothPriceTypeDTO] object representing the fetched detail customer data.
  /// 
  Future<ClothPriceTypeDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final ClothPriceTypeDTO response = await dioClient.getRequest(
      "api/cloth-price-types/$id",
      converter: (data) => ClothPriceTypeDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores customer data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/cloth-price-types"
  /// in order to store customer data. It takes a [payload] parameter containing
  /// the customer data to be stored. The function returns a [ClothPriceTypeDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [ClothPriceTypeDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload payload = customerPayload(/* ... */);
  /// final ClothPriceTypeDTO customer = await storeData(payload);
  /// print("customer stored: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothPriceTypeDTO>] representing the stored customer data.
  Future<ClothPriceTypeDTO> storeData(ClothPriceTypePayload payload) async {
    final ClothPriceTypeDTO response = await dioClient.postRequest(
      "api/cloth-price-types", 
      converter: (data) => ClothPriceTypeDTO.fromJson(data), 
      payload: payload
    );
    return response;
  }

  /// Updates customer data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/cloth-price-types"
  /// in order to update customer data. It takes a [payload] parameter containing
  /// the updated customer data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [ClothPriceTypeDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload updatedPayload = customerPayload(/* ... */);
  /// final ClothPriceTypeDTO customer = await updateData(updatedPayload);
  /// print("customer updated: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothPriceTypeDTO>] representing the updated customer data.
  Future<ClothPriceTypeDTO> updateData(String id, ClothPriceTypePayload paylaod) async {
    final ClothPriceTypeDTO response = await dioClient.patchRequest(
      "api/cloth-price-types/$id", 
      converter: (data) => ClothPriceTypeDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes customer data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/cloth-price-types"
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
      "api/cloth-price-types", 
      converter: (data) => null,
      id: id
    );
  }
}