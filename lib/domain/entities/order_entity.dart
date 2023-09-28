
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';
import 'package:pos_application_mobile/domain/entities/order_history_log_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_payment_log_entity.dart';
import 'package:pos_application_mobile/domain/entities/updated_by_entity.dart';

class OrderEntity extends Entity  {
  final String? id;
  final CreatedByEntity? createdBy;
  final String? orderNumber;
  final String? createdAt;
  final String? status;
  final String? paymentMethod;
  final int? totalQty;
  final int? amountDownPayment;
  final int? total;
  final int? profit;
  final UpdatedByEntity? updatedBy;
  final String? updatedAt;
  final CustomerEntity? customer;
  final List<ClothEntity>? cloths;
  final List<OrderPaymentLogEntity>? orderPaymentLog;
  final List<OrderHistoryLogEntity>? orderHistoryLog;

  OrderEntity({
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
    this.updatedBy,
    this.updatedAt,
    this.customer,
    this.cloths,
    this.orderPaymentLog,
    this.orderHistoryLog,
  });
  
  @override
  OrderEntity copyWith({
    String? id,
    CreatedByEntity? createdBy,
    String? orderNumber,
    String? createdAt,
    String? status,
    String? paymentMethod,
    int? totalQty,
    int? amountDownPayment,
    int? total,
    int? profit,
    UpdatedByEntity? updatedBy,
    String? updatedAt,
    CustomerEntity? customer,
    List<ClothEntity>? cloths,
    List<OrderPaymentLogEntity>? orderPaymentLog,
    List<OrderHistoryLogEntity>? orderHistoryLog
  }) {
    return OrderEntity(
      amountDownPayment: amountDownPayment ?? this.amountDownPayment,
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      orderNumber: orderNumber ?? this.orderNumber,
      createdAt: createdAt ?? this.createdAt,
      cloths: cloths ?? this.cloths,
      customer: customer ?? this.customer,
      orderHistoryLog: orderHistoryLog ?? this.orderHistoryLog,
      orderPaymentLog: orderPaymentLog ?? this.orderPaymentLog,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      profit: profit ?? this.profit,
      status: status ?? this.status,
      total: total ?? this.total,
      totalQty: totalQty ?? this.totalQty,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy
    );
  }
  
  @override
  List<Object?> get props => [
    amountDownPayment,
    id,
    createdBy,
    orderNumber,
    createdAt,
    cloths,
    customer,
    orderHistoryLog,
    orderPaymentLog,
    paymentMethod,
    profit,
    status,
    total,
    totalQty,
    updatedAt,
    updatedBy
  ];
} 