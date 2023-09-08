import 'package:pos_application_mobile/data/payloads/cloth_size_payload.dart';
import 'package:pos_application_mobile/data/payloads/payload.dart';

class ClothColorPayload extends Payload  {
  String name;
  String colorId;
  String sku;
  String color;
  List<ClothSizePayload> clothSize;

  ClothColorPayload({
    this.name = '',
    this.color = 'ffffff',
    required this.clothSize,
    required this.colorId,
    required this.sku
  });
  
  @override
  Map<String, dynamic> toJson([List<String>? remove]) {
    final jsonResult = {
      "color_id": colorId,
      "sku": sku,
      "cloth_size": clothSize
    };

    if (remove != null) {
      for (var element in remove) {
        jsonResult.remove(element);
      }
      return jsonResult;
    }
    return jsonResult;
  }


  @override
  bool operator ==(Object other) =>
    other is ClothColorPayload &&
    other.colorId == colorId &&
    other.name == name &&
    other.sku == sku;

  @override
  int get hashCode => name.hashCode  ^ color.hashCode ^ sku.hashCode ^ color.hashCode;
}