import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/color_dto.dart';
import 'package:pos_application_mobile/data/payloads/color_payload.dart';

class ColorDataSource extends RemoteDataSource {

  /* handling fetch list data for color */
  Future<List<ColorDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ColorDTO> response = await dioClient.getRequest(
      "api/colors",
      converter: (data) => List<ColorDTO>.from(
        data["data"].map((d) => ColorDTO.fromJson(d))
      ),
      queryParameters: queryParameters
    );
    return response;
  }

  /* handling store new color */
  Future<ColorDTO> storeData(ColorPayload payload) async {
    final ColorDTO response = await dioClient.postRequest(
      "api/colors",
      converter: (data) => ColorDTO.fromJson(data),
      payload: payload
    );
    return response;
  }

  /// handling delete color 
  /// 
  /// The [id] params is required
  Future<void> deleteData(String id) async {
    await dioClient.deleteRequest(
      "api/colors", 
      converter: (data) => null,
      id: id
    );
  }

  /// Handling update color
  /// 
  /// The [id] and [payload] is required parameters
  Future<ColorDTO> updateData(String id, ColorPayload payload) async {
    final ColorDTO response = await dioClient.patchRequest(
      "api/colors/$id",
      converter: (data) => ColorDTO.fromJson(data),
      payload: payload
    );

    return response;
  }
}