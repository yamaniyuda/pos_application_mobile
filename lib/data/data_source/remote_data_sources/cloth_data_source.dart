// ignore_for_file: unused_local_variable

import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_color_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_dto.dart';
import 'package:pos_application_mobile/data/payloads/cloth_color_payload.dart';
import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';

class ClothDataSource extends RemoteDataSource {

  /// Fetches cloth price type data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving customer data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [ClothDTO] objects representing the fetched customer data.
  ///
  Future<List<ClothDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothDTO> response = await dioClient.getRequest(
      "api/clothes",
      converter: (data) => List<ClothDTO>.from(
        data["data"].map((d) => ClothDTO.fromJson(d)),
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
  /// A [ClothDTO] object representing the fetched detail customer data.
  /// 
  Future<ClothDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final ClothDTO response = await dioClient.getRequest(
      "api/clothes/$id",
      converter: (data) => ClothDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores customer data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/clothes"
  /// in order to store customer data. It takes a [payload] parameter containing
  /// the customer data to be stored. The function returns a [ClothDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [ClothDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload payload = customerPayload(/* ... */);
  /// final ClothDTO customer = await storeData(payload);
  /// print("customer stored: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothDTO>] representing the stored customer data.
  Future<String> storeData(ClothPayload payload) async {
    final String respone = await dioClient.postRequest(
      "api/clothes", 
      converter: (data) => data, 
      payload: payload
    );

    return respone;
  }

  /// Updates customer data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/clothes"
  /// in order to update customer data. It takes a [payload] parameter containing
  /// the updated customer data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [ClothDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final customerPayload updatedPayload = customerPayload(/* ... */);
  /// final ClothDTO customer = await updateData(updatedPayload);
  /// print("customer updated: ${customer.customername}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothDTO>] representing the updated customer data.
  Future<ClothDTO> updateData(String id, ClothPayload paylaod) async {
    final ClothDTO response = await dioClient.patchRequest(
      "api/clothes/$id", 
      converter: (data) => ClothDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes customer data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/clothes"
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
      "api/clothes", 
      converter: (data) => null,
      id: id
    );
  }


  /// Add cloth color to remote storage.
  /// 
  /// This function will send payload to "api/clothers/:id/color" that will later 
  /// be used for add new color data to exist cloth data.
  /// 
  /// The [dioClient] should be a preconfigurated instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameters is a function
  /// that can be used to convert to raw respone data from the API, in this case
  /// it's set to `(data) => null` since no response data is expected.
  /// 
  /// Example usage:
  /// ```dart
  /// final String id = "323323";
  /// final ClothColorPayload payload = ClothColorPayload(/*...*/);
  /// await addClothColor(id, payload);
  /// ```
  /// 
  /// Will rethrows errors if the network request fails.
  /// 
  /// Parameters:
  /// - [id] - The identifier of the cloth to add.
  /// - [payload] - The objct [ClothColorPayload] that used for send to remote data source.
  Future<void> addClothColor(String id, ClothPayload payload) async {
    await dioClient.postRequest(
      "api/clothes/$id/color",
      converter: (data) => null,
      payload: payload.toJson("cloth_category_id")
    );
  } 


  /// Add Cloth Size.
  /// 
  /// This function will send payload to "api/clothers/:id/:cloth_id/size" that will later
  /// be used for add new size data to exist cloth color.
  /// 
  /// The [dioClient] should be a preconfigurate instance of a Dio HTTP client,
  /// used to make the network request. The [converter] paramter is a function
  /// that can be used to convert to raw response data from the API, in this case
  /// it's set to `(data) => null` since no response dat is expected.
  /// 
  /// Example usage:
  /// ```dart
  /// final clothId = '3235';
  /// final clothColorId: '3235';
  /// final payload = ClothColorPayload(/*...*/);
  /// 
  /// addClothSize(clothId, clothColorId, payload);
  /// ```
  Future<void> addClothSize(String id, String colorId, ClothColorPayload payload) async {
    await dioClient.postRequest(
      "api/clothes/$id/color/$colorId/size",
      converter: (data) => null,
      payload: payload.toJson(["color_id", "sku"])
    );
  }


  /// Asynchronously fetches cloth data by SKU (Stock Keeping Unit) from a remote API.
  ///
  /// This function sends a GET request to the specified API endpoint with the
  /// provided SKU and waits for the response. It then converts the response
  /// data into a [ClothDTO] object using the provided JSON converter function.
  ///
  /// Parameters:
  /// - `sku` (String): The Stock Keeping Unit (SKU) for the cloth to be fetched.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [ClothDTO] object containing cloth information.
  ///
  /// Throws:
  /// - Throws an error if the GET request fails or if the JSON conversion fails.
  ///
  /// Example usage:
  /// ```dart
  /// final ClothDTO clothData = await fetchDataBySku("ABC123");
  /// print(clothData.name); // Print the name of the cloth.
  /// ```
  Future<ClothColorDTO> fetchDataBySku(String sku, String customerCategoryId) async {
    final ClothColorDTO response = await dioClient.getRequest(
      "api/cloth-colors/sku/$sku", 
      queryParameters: { "find_by_sku": 1 , "customer_category_id": customerCategoryId},
      converter: (response) => ClothColorDTO.fromJson(response),
    );
    return response;
  }
}