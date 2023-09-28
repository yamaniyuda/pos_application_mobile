
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';

class OrderHistoryLogEntity extends Entity  {
  final String? id;
  final CreatedByEntity? createdBy;
  final String? paymentMethod;
  final String? status;
  final String? note;
  final String? createdAt;

  OrderHistoryLogEntity({
    this.id,
    this.createdBy,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.note,
  });
  
  @override
  OrderHistoryLogEntity copyWith({
    String? id,
    CreatedByEntity? createdBy,
    String? paymentMethod,
    String? status,
    String? createdAt,
    String? note
  }) {
    return OrderHistoryLogEntity(
      createdBy: createdBy ?? this.createdBy,
      id: id ?? this.id,
      note: note ?? this.note,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt
    );
  }
  
  @override
  List<Object?> get props => [id, createdBy, paymentMethod, status, note];
  
} 