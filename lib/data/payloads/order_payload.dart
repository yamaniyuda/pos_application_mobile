class OrderPayload {
  late String? id;
  late String paymentMethod;
  late String? amountDownPayment;
  late String customerCategory;
  late String? customerId;
  late List<OrderDetailPayload> orderDetails;

  OrderPayload({
    this.id,
    required this.paymentMethod,
    required this.amountDownPayment,
    required this.customerCategory,
    required this.customerId,
    required this.orderDetails
  });

  Map<String, dynamic> toJson() {
    return {
      "payment_method": paymentMethod,
      "amount_down_payment": amountDownPayment,
      "customer_category": customerCategory,
      "order_details": List.from(
        orderDetails.map((e) => e.toJson())
      )
    };
  }
}

class OrderDetailPayload {
  late String clothSizeId;
  late String clothSizePriceId;
  late int qyt;

  OrderDetailPayload({
    required this.clothSizeId,
    required this.clothSizePriceId,
    required this.qyt
  });

  Map<String, dynamic> toJson() {
    return {
      "cloth_size_id": clothSizeId,
      "cloth_size_price_id": clothSizePriceId,
      "qyt": qyt
    };
  }
}