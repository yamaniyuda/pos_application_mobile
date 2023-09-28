import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'order_payment_log_dto.g.dart';

@JsonSerializable()
class OrderPaymentLogDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "created_by")
  late CreatedByDTO? createdBy;

  @JsonKey(name: "payment_method")
  late String? paymentMethod;

  @JsonKey(name: 'status')
  late String? status;

  @JsonKey(name: 'type')
  late String? type;

  @JsonKey(name: 'total')
  late int? total;

  @JsonKey(name: "created_at")
  late String? createdAt;

  @JsonKey(name: 'note')
  late String? note;

  @JsonKey(name: 'attachment')
  late String? attachment;

  OrderPaymentLogDTO({
    this.id,
    this.createdBy,
    this.paymentMethod,
    this.status,
    this.type,
    this.total,
    this.note,
    this.attachment,
    this.createdAt
  });
  
  factory OrderPaymentLogDTO.fromJson(Map<String, dynamic> json) {
    return _$OrderPaymentLogDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$OrderPaymentLogDTOToJson(this);
  }
} 