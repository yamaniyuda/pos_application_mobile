class OrderPayload {
  late String? id;
  late String paymentMethod;
  late int? amountDownPayment;
  late String customerCategory;
  late int? discount = 0;
  late String? customerId;
  late List<OrderDetailPayload> orderDetails;

  OrderPayload(
      {this.id,
      required this.paymentMethod,
      required this.amountDownPayment,
      required this.customerCategory,
      required this.customerId,
      required this.orderDetails,
      this.discount});

  Map<String, dynamic> toJson() {
    try {
      late Map<String, dynamic> wrapJson = {
        "payment_method": paymentMethod,
        "amount_down_payment": amountDownPayment,
        "discount": discount,
        "customer_category": customerCategory,
        "order_details": List.from(orderDetails.map((e) => e.toJson()))
      };

      if (customerId != "" || customerId != null) {
        wrapJson.addAll({
          "customer_id": customerId,
        });
      }

      return wrapJson;
    } catch (e) {
      rethrow;
    }
  }
}

class OrderDetailPayload {
  late String clothSizeId;
  late String clothSizePriceId;
  late int qyt;

  OrderDetailPayload(
      {required this.clothSizeId,
      required this.clothSizePriceId,
      required this.qyt});

  Map<String, dynamic> toJson() {
    return {
      "cloth_size_id": clothSizeId,
      "cloth_size_price_id": clothSizePriceId,
      "qty": qyt
    };
  }
}
