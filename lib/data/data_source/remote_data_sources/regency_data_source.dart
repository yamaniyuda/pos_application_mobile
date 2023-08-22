import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/regency_dto.dart';

class RegencyDataSource extends RemoteDataSource {

  /// Fetches regency data from a remote API.
  /// 
  /// The `fetchData` function is responsible for retrieving regency data from an API.
  /// It parse the JSON response and converts it into Dart data objects.
  /// 
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [RegencyDTO] objects representing the fetched user data.
  ///
  Future<List<RegencyDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<RegencyDTO> response = await dioClient.getRequest(
      "api/regencies",
      converter: (data) => List<RegencyDTO>.from(
        data["data"].map((d) => RegencyDTO.fromJson(d))
      ),
      queryParameters: queryParameters
    );
    return response;
  }
}