import 'package:json_annotation/json_annotation.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/dto.dart';

part 'order_history_log_dto.g.dart';

@JsonSerializable()
class OrderHistoryLogDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "created_by")
  late CreatedByDTO? createdBy;

  @JsonKey(name: "payment_method")
  late String? paymentMethod;

  @JsonKey(name: 'status')
  late String? status;

  @JsonKey(name: "created_at")
  late String? createdAt;

  @JsonKey(name: 'note')
  late String? note;

  OrderHistoryLogDTO({
    this.id,
    this.createdBy,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.note,
  });
  
  factory OrderHistoryLogDTO.fromJson(Map<String, dynamic> json) {
    return _$OrderHistoryLogDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$OrderHistoryLogDTOToJson(this);
  }
} 