
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/entity.dart';

class OrderPaymentLogEntity extends Entity  {
  final String? id;
  final CreatedByEntity? createdBy;
  final String? paymentMethod;
  final String? status;
  final String? note;
  final String? type;
  final int? total;
  final String? attachment;


  OrderPaymentLogEntity({
    this.id,
    this.createdBy,
    this.paymentMethod,
    this.status,
    this.note,
    this.type,
    this.total,
    this.attachment
  });
  
  @override
  OrderPaymentLogEntity copyWith({
    String? id,
    CreatedByEntity? createdBy,
    String? paymentMethod,
    String? status,
    String? note
  }) {
    return OrderPaymentLogEntity(
      createdBy: createdBy ?? this.createdBy,
      id: id ?? this.id,
      note: note ?? this.note,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status
    );
  }
  
  @override
  List<Object?> get props => [id, createdBy, paymentMethod, status, note];
} 