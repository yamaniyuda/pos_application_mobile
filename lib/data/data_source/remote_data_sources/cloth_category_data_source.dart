import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_categoty_dto.dart';
import 'package:pos_application_mobile/data/payloads/cloth_category_payload.dart';

class ClothCategoryDataSource extends RemoteDataSource {

  /// Fetches cloth category data from a remote API.
  ///
  /// The `fetchData` function is responsible for retrieving cloth category data from an API.
  /// It parses the JSON response and converts it into Dart data objects.
  ///
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [ClothCategoryDTO] objects representing the fetched cloth category data.
  ///
  Future<List<ClothCategoryDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothCategoryDTO> response = await dioClient.getRequest(
      "api/cloth-categories",
      converter: (data) => List<ClothCategoryDTO>.from(
        data["data"].map((d) => ClothCategoryDTO.fromJson(d)),
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
  /// A [ClothCategoryDTO] object representing the fetched detail cloth category data.
  /// 
  Future<ClothCategoryDTO> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final ClothCategoryDTO response = await dioClient.getRequest(
      "api/cloth-categories/$id",
      converter: (data) => ClothCategoryDTO.fromJson(data),
      queryParameters: queryParameters
    );

    return response;
  }

  /// Stores cloth category data to the remote API.
  ///
  /// This function sends a POST request to the remote API endpoint "api/cloth-categories"
  /// in order to store cloth category data. It takes a [payload] parameter containing
  /// the cloth category data to be stored. The function returns a [ClothCategoryDTO] object
  /// representing the response received from the API after storing the data.
  ///
  /// The [dioClient] is expected to be a preconfigured instance of a Dio HTTP
  /// client, used to make the network request. The [converter] parameter is
  /// a function that converts the raw response data from the API into a [ClothCategoryDTO]
  /// object.
  ///
  /// Example usage:
  /// ```dart
  /// final cloth categoryPayload payload = cloth categoryPayload(/* ... */);
  /// final ClothCategoryDTO storedcloth category = await storeData(payload);
  /// print("cloth category stored: ${storedcloth category.cloth categoryname}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothCategoryDTO>] representing the stored cloth category data.
  Future<ClothCategoryDTO> storeData(ClothCategoryPayload payload) async {
    final ClothCategoryDTO response = await dioClient.postRequest(
      "api/cloth-categories", 
      converter: (data) => ClothCategoryDTO.fromJson(data), 
      payload: payload
    );
    return response;
  }

  /// Updates cloth category data on the remote API.
  ///
  /// This function sends a PATCH request to the remote API endpoint "api/cloth-categories"
  /// in order to update cloth category data. It takes a [payload] parameter containing
  /// the updated cloth category data to be sent to the API.
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that converts the raw response data from the API into a [ClothCategoryDTO] object.
  ///
  /// Example usage:
  /// ```dart
  /// final cloth categoryPayload updatedPayload = cloth categoryPayload(/* ... */);
  /// final ClothCategoryDTO updatedcloth category = await updateData(updatedPayload);
  /// print("cloth category updated: ${updatedcloth category.cloth categoryname}");
  /// ```
  ///
  /// Throws an error if the network request fails or if there's an issue
  /// converting the response data.
  ///
  /// Returns a [Future<ClothCategoryDTO>] representing the updated cloth category data.
  Future<ClothCategoryDTO> updateData(String id, ClothCategoryPayload paylaod) async {
    final ClothCategoryDTO response = await dioClient.patchRequest(
      "api/cloth-categories/$id", 
      converter: (data) => ClothCategoryDTO.fromJson(data), 
      payload: paylaod
    );
    return response;
  }

  /// Deletes cloth category data from the remote API.
  ///
  /// This function sends a DELETE request to the remote API endpoint "api/cloth-categories"
  /// to delete cloth category data associated with the given [id].
  ///
  /// The [dioClient] should be a preconfigured instance of a Dio HTTP client,
  /// used to make the network request. The [converter] parameter is a function
  /// that can be used to convert the raw response data from the API; in this
  /// case, it's set to `(data) => null` since no response data is expected.
  ///
  /// Example usage:
  /// ```dart
  /// final String cloth categoryIdToDelete = "12345";
  /// await deleteData(cloth categoryIdToDelete);
  /// print("cloth category with ID $cloth categoryIdToDelete deleted successfully.");
  /// ```
  ///
  /// Throws an error if the network request fails.
  ///
  /// Parameters:
  /// - [id]: The identifier of the cloth category to be deleted.
  ///
  /// Returns a [Future<void>] indicating the completion of the delete operation.
  Future<void> deleteData(String id) async {
    await dioClient.deleteRequest(
      "api/cloth-categories", 
      converter: (data) => null,
      id: id
    );
  }
}