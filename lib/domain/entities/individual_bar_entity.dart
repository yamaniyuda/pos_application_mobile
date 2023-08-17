import 'package:pos_application_mobile/domain/entities/entity.dart';

class IndividualBarEntity extends Entity {
  final int x;
  final double y;

  IndividualBarEntity({
    required this.x,
    required this.y
  });

  @override
  IndividualBarEntity copyWith({ int? x, double? y }) {
    return IndividualBarEntity(
      x: x ?? this.x,
      y: y ?? this.y
    );
  }

  @override
  List<Object?> get props => [x, y];
}