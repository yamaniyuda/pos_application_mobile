import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/village_dto.dart';

class VillageDataSource extends RemoteDataSource {

  /* handling fetch list data for villages */
  Future<List<VillageDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<VillageDTO> response = await dioClient.getRequest(
      "api/villages",
      converter: (data) => List<VillageDTO>.from(
        data["data"].map((d) => VillageDTO.fromJson(d))
      ),
      queryParameters: queryParameters
    );
    return response;
  }
}