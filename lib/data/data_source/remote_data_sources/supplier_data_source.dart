import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/supplier_dto.dart';
import 'package:pos_application_mobile/data/payloads/supplier_payload.dart';

class SupplierDataSource extends RemoteDataSource {

  /// Fetches supplier data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving supplier data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [SupplierDTO] objects representing the fetched supplier data.
  ///
  Future<List<SupplierDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<SupplierDTO> response = await dioClient.getRequest(
      "api/suppliers",
      converter: (data) => List<SupplierDTO>.from(
        data["data"].map((d) => SupplierDTO.fromJson(d)),
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
  /// A [SupplierDTO] object representing the fetched detail supplier data.
  /// 
  Future<SupplierDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final SupplierDTO response = await dioClient.getRequest(
      "api/suppliers/$id",
      converter: (data) => SupplierDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores supplier data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/suppliers"
  /// in order to store supplier data. It takes a [payload] parameter containing
  /// the supplier data to be stored. The function returns a [SupplierDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [SupplierDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final supplierPayload payload = supplierPayload(/* ... */);
  /// final SupplierDTO storedsupplier = await storeData(payload);
  /// print("supplier stored: ${storedsupplier.suppliername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<SupplierDTO>] representing the stored supplier data.
  Future<SupplierDTO> storeData(SupplierPayload payload) async {
    final SupplierDTO response = await dioClient.postRequest(
      "api/suppliers", 
      converter: (data) => SupplierDTO.fromJson(data), 
      payload: payload
    );
    return response;
  }

  /// Updates supplier data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/suppliers"
  /// in order to update supplier data. It takes a [payload] parameter containing
  /// the updated supplier data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [SupplierDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final supplierPayload updatedPayload = supplierPayload(/* ... */);
  /// final SupplierDTO updatedsupplier = await updateData(updatedPayload);
  /// print("supplier updated: ${updatedsupplier.suppliername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<SupplierDTO>] representing the updated supplier data.
  Future<SupplierDTO> updateData(String id, SupplierPayload paylaod) async {
    final SupplierDTO response = await dioClient.patchRequest(
      "api/suppliers/$id", 
      converter: (data) => SupplierDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes supplier data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/suppliers"
  /// to delete supplier data associated with the given [id].
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that can be used to convert the raw response data from the API; in this
  /// case, it's set to `(data) => null` since no response data is expected.
  ///
  /// Example usage:
  /// ```dart
  /// final String supplierIdToDelete = "12345";
  /// await deleteData(supplierIdToDelete);
  /// print("supplier with ID $supplierIdToDelete deleted successfully.");
  /// ```
  ///
  /// Throws an error if the network request fails.
  ///
  /// Parameters:
  /// - [id]: The identifier of the supplier to be deleted.
  ///
  /// Returns a [Future<void>] indicating the completion of the delete operation.
  Future<void> deleteData(String id) async {
    await dioClient.deleteRequest(
      "api/suppliers", 
      converter: (data) => null,
      id: id
    );
  }
}