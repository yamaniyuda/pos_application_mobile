import 'package:pos_application_mobile/data/payloads/cloth_price_payload.dart';
import 'package:pos_application_mobile/data/payloads/payload.dart';

class ClothSizePayload extends Payload {
  late String name;
  late String sizeId;
  late int stock;
  late List<ClothPricePayload> clothPrice = [];

  ClothSizePayload({
    this.name = '',
    this.sizeId = '',
    this.stock = 0,
    required this.clothPrice
  });
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "size_id": sizeId,
      "stock": stock,
      "cloth_price": clothPrice
    };  
  }
}