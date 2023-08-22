import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/customer_type_dto.dart';
import 'package:pos_application_mobile/data/payloads/customer_type_payload.dart';

class CustomerTypeDataSource extends RemoteDataSource {

  /// Fetches customer type data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving customer type data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [CustomerTypeDTO] objects representing the fetched customer type data.
  ///
  Future<List<CustomerTypeDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<CustomerTypeDTO> response = await dioClient.getRequest(
      "api/customer-categories",
      converter: (data) => List<CustomerTypeDTO>.from(
        data["data"].map((d) => CustomerTypeDTO.fromJson(d)),
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
  /// A [CustomerTypeDTO] object representing the fetched detail customer type data.
  /// 
  Future<CustomerTypeDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final CustomerTypeDTO response = await dioClient.getRequest(
      "api/customer-categories/$id",
      converter: (data) => CustomerTypeDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores customer type data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/customer-categories"
  /// in order to store customer type data. It takes a [payload] parameter containing
  /// the customer type data to be stored. The function returns a [CustomerTypeDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [CustomerTypeDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final customer typePayload payload = customer typePayload(/* ... */);
  /// final CustomerTypeDTO storedcustomer type = await storeData(payload);
  /// print("customer type stored: ${storedcustomer type.customer typename}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<CustomerTypeDTO>] representing the stored customer type data.
  Future<CustomerTypeDTO> storeData(CustomerTypePayload payload) async {
    final CustomerTypeDTO response = await dioClient.postRequest(
      "api/customer-categories", 
      converter: (data) => CustomerTypeDTO.fromJson(data), 
      payload: payload
    );
    return response;
  }

  /// Updates customer type data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/customer-categories"
  /// in order to update customer type data. It takes a [payload] parameter containing
  /// the updated customer type data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [CustomerTypeDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final customer typePayload updatedPayload = customer typePayload(/* ... */);
  /// final CustomerTypeDTO updatedcustomer type = await updateData(updatedPayload);
  /// print("customer type updated: ${updatedcustomer type.customer typename}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<CustomerTypeDTO>] representing the updated customer type data.
  Future<CustomerTypeDTO> updateData(String id, CustomerTypePayload paylaod) async {
    final CustomerTypeDTO response = await dioClient.patchRequest(
      "api/customer-categories/$id", 
      converter: (data) => CustomerTypeDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes customer type data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/customer-categories"
  /// to delete customer type data associated with the given [id].
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that can be used to convert the raw response data from the API; in this
  /// case, it's set to `(data) => null` since no response data is expected.
  ///
  /// Example usage:
  /// ```dart
  /// final String customer typeIdToDelete = "12345";
  /// await deleteData(customer typeIdToDelete);
  /// print("customer type with ID $customer typeIdToDelete deleted successfully.");
  /// ```
  ///
  /// Throws an error if the network request fails.
  ///
  /// Parameters:
  /// - [id]: The identifier of the customer type to be deleted.
  ///
  /// Returns a [Future<void>] indicating the completion of the delete operation.
  Future<void> deleteData(String id) async {
    await dioClient.deleteRequest(
      "api/customer-categories", 
      converter: (data) => null,
      id: id
    );
  }
}