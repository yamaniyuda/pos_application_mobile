import 'package:pos_application_mobile/data/payloads/payload.dart';

class StockAdjustmentItemPayload extends Payload {
  final int stock;
  final String clothSizeId;

  StockAdjustmentItemPayload({
    required this.clothSizeId,
    required this.stock
  });
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "cloth_size_id": clothSizeId,
      "stock": stock
    };
  }
}