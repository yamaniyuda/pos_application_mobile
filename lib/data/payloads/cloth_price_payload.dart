import 'package:pos_application_mobile/data/payloads/payload.dart';

class ClothPricePayload extends Payload {
  late String clothPriceTypeId;
  late int price;

  ClothPricePayload({
    required this.clothPriceTypeId,
    required this.price
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "cloth_price_type_id": clothPriceTypeId,
      "price": price
    };
  }
}