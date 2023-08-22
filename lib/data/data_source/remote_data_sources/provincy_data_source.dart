import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/provincy_dto.dart';

class ProvincyDataSource extends RemoteDataSource {

  /* handling fetch list data for provinces */
  Future<List<ProvincyDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ProvincyDTO> response = await dioClient.getRequest(
      "api/provinces",
      converter: (data) => List<ProvincyDTO>.from(
        data["data"].map((d) => ProvincyDTO.fromJson(d))
      ),
      queryParameters: queryParameters
    );
    return response;
  }
}