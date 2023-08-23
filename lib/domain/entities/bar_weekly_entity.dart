import 'package:pos_application_mobile/domain/entities/entity.dart';
import 'package:pos_application_mobile/domain/entities/individual_bar_entity.dart';

// ignore: must_be_immutable
class BarWeeklyEntity extends Entity {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarWeeklyEntity({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  BarWeeklyEntity copyWith({
    double? sunAmount,
    double? monAmount,
    double? tueAmount,
    double? wedAmount,
    double? thurAmount,
    double? friAmount,
    double? satAmount
  }) {
    return BarWeeklyEntity(
      friAmount: friAmount ?? this.friAmount,
      monAmount: monAmount ?? this.monAmount,
      satAmount: satAmount ?? this.satAmount,
      sunAmount: sunAmount ?? this.sunAmount,
      thurAmount: thurAmount ?? this.thurAmount,
      tueAmount: tueAmount ?? this.tueAmount,
      wedAmount: wedAmount ?? this.wedAmount
    );
  }

  @override
  List<Object?> get props => [
    friAmount,
    monAmount,
    satAmount,
    sunAmount,
    thurAmount,
    tueAmount,
    wedAmount
  ];

  List<IndividualBarEntity> barData = [];

  void initializeBarWeekly() {
    barData = [
      IndividualBarEntity(x: 0, y: friAmount),
      IndividualBarEntity(x: 1, y: monAmount),
      IndividualBarEntity(x: 2, y: satAmount),
      IndividualBarEntity(x: 3, y: sunAmount),
      IndividualBarEntity(x: 4, y: thurAmount),
      IndividualBarEntity(x: 5, y: tueAmount),
      IndividualBarEntity(x: 6, y: wedAmount),
    ];
  }
}