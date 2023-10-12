import 'package:pos_application_mobile/data/payloads/payload.dart';
import 'package:pos_application_mobile/data/payloads/stock_adjustment_item_payload.dart';

class StockAdjustmentPayload extends Payload {
  final List<StockAdjustmentItemPayload> stockAdjustmentsPayload;

  StockAdjustmentPayload({
    required this.stockAdjustmentsPayload
  });
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "stock_adjusments": List.from(
        stockAdjustmentsPayload.map((d) => d.toJson())
      )
    };
  }
}