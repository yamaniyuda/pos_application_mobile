import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/customer_dto.dart';
import 'package:pos_application_mobile/data/payloads/customer_payload.dart';

class CustomerDataSource extends RemoteDataSource {

  /// Fetches customer data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving customer data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [CustomerDTO] objects representing the fetched customer data.
  ///
  Future<List<CustomerDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<CustomerDTO> response = await dioClient.getRequest(
      "api/customers",
      converter: (data) => List<CustomerDTO>.from(
        data["data"].map((d) => CustomerDTO.fromJson(d)),
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
  /// A [CustomerDTO] object representing the fetched detail customer data.
  /// 
  Future<CustomerDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final CustomerDTO response = await dioClient.getRequest(
      "api/customers/$id",
      converter: (data) => CustomerDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores customer data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/customers"
  /// in order to store customer data. It takes a [payload] parameter containing
  /// the customer data to be stored. The function returns a [CustomerDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [CustomerDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload payload = customerPayload(/* ... */);
  /// final CustomerDTO customer = await storeData(payload);
  /// print("customer stored: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<CustomerDTO>] representing the stored customer data.
  Future<CustomerDTO> storeData(CustomerPayload payload) async {
    final CustomerDTO response = await dioClient.postRequest(
      "api/customers", 
      converter: (data) => CustomerDTO.fromJson(data), 
      payload: payload
    );
    return response;
  }

  /// Updates customer data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/customers"
  /// in order to update customer data. It takes a [payload] parameter containing
  /// the updated customer data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [CustomerDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload updatedPayload = customerPayload(/* ... */);
  /// final CustomerDTO customer = await updateData(updatedPayload);
  /// print("customer updated: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<CustomerDTO>] representing the updated customer data.
  Future<CustomerDTO> updateData(String id, CustomerPayload paylaod) async {
    final CustomerDTO response = await dioClient.patchRequest(
      "api/customers/$id", 
      converter: (data) => CustomerDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes customer data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/customers"
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
      "api/customers", 
      converter: (data) => null,
      id: id
    );
  }
}