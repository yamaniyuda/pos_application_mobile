import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/district_dto.dart';

class DistrictDataSource extends RemoteDataSource {

  /// Fetches provincy data from a remote API.
  /// 
  /// The `fetchData` function is responsible for retrieving provincy data from an API.
  /// It parse the JSON response and converts it into Dart data objects.
  /// 
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [DistrictDTO] objects representing the fetched user data.
  ///
  Future<List<DistrictDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<DistrictDTO> response = await dioClient.getRequest(
      "api/districts",
      converter: (data) => List<DistrictDTO>.from(
        data["data"].map((d) => DistrictDTO.fromJson(d))
      ),
      queryParameters: queryParameters
    );
    return response;
  }
}