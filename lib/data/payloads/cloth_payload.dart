import 'package:pos_application_mobile/data/payloads/cloth_color_payload.dart';
import 'package:pos_application_mobile/data/payloads/payload.dart';

class ClothPayload extends Payload {
  late String id;
  late String? clothCategoryId;
  late List<ClothColorPayload> clothColor;

  ClothPayload({
    this.id = '',
    this.clothCategoryId,
    required this.clothColor
  });
  
  @override
  Map<String, dynamic> toJson([String? remove]) {
    final jsonResult = {
      "cloth_category_id": clothCategoryId,
      "cloth_color": clothColor
    };

    if (remove != null) {
      jsonResult.remove(remove);
      return jsonResult;
    }
    return jsonResult;
  }
}