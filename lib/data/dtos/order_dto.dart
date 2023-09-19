import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_dto.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/customer_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_history_log_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_payment_log_dto.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDTO {
  @JsonKey(name: 'id')
  late String? id;

  @JsonKey(name: 'created_by')
  late CreatedByDTO? createdBy;

  @JsonKey(name: 'order_number')
  late String? orderNumber;

  @JsonKey(name: 'created_at')
  late String? createdAt;

  @JsonKey(name: 'status')
  late String? status;

  @JsonKey(name: 'payment_method')
  late String? paymentMethod;

  @JsonKey(name: 'total_qty')
  late int? totalQty;

  @JsonKey(name: 'amount_down_payment')
  late int? amountDownPayment;

  @JsonKey(name: 'total')
  late int? total;

  @JsonKey(name: 'profit')
  late int? profit;

  @JsonKey(name: 'updated_by')
  late dynamic updatedBy; // You can change the type based on your needs

  @JsonKey(name: 'updated_at')
  late String? updatedAt;

  @JsonKey(name: 'customer')
  late CustomerDTO? customer;

  @JsonKey(name: 'cloths')
  late List<ClothDTO>? cloths;

  @JsonKey(name: 'order_payment_log')
  late List<OrderPaymentLogDTO>? orderPaymentLog;

  @JsonKey(name: 'order_history_log')
  late List<OrderHistoryLogDTO>? orderHistoryLog;

  OrderDTO({
    this.id,
    this.createdBy,
    this.orderNumber,
    this.createdAt,
    this.status,
    this.paymentMethod,
    this.totalQty,
    this.amountDownPayment,
    this.total,
    this.profit,
    this.cloths,
    this.updatedBy,
    this.updatedAt,
    this.customer,
    this.orderHistoryLog,
    this.orderPaymentLog
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return _$OrderDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderDTOToJson(this);
  }
}