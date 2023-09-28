// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_mapper.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template package:pos_application_mobile/data/mappers/order_mapper.dart}
/// Available mappings:
/// - `OrderDTO` → `OrderEntity`.
/// - `OrderEntity` → `OrderDTO`.
/// {@endtemplate}
class $OrderMapper implements AutoMapprInterface {
  const $OrderMapper();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<OrderDTO>() ||
            sourceTypeOf == _typeOf<OrderDTO?>()) &&
        (targetTypeOf == _typeOf<OrderEntity>() ||
            targetTypeOf == _typeOf<OrderEntity?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<OrderEntity>() ||
            sourceTypeOf == _typeOf<OrderEntity?>()) &&
        (targetTypeOf == _typeOf<OrderDTO>() ||
            targetTypeOf == _typeOf<OrderDTO?>())) {
      return true;
    }
    if (recursive) {
      for (final mappr in _modules) {
        if (mappr.canConvert<SOURCE, TARGET>()) {
          return true;
        }
      }
    }
    return false;
  }

  /// {@macro AutoMapprInterface:convert}
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _convert(model)!;
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convert(model)!;
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:tryConvert}
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _convert(
        model,
        canReturnNull: true,
      );
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvert(model);
      }
    }

    return null;
  }

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET>((item) => _convert(item)!);
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertIterable(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
      Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET?>((item) => _convert(item, canReturnNull: true));
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertIterable(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toList();
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertList(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(model).toList();
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertList(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toSet();
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertSet(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:pos_application_mobile/data/mappers/order_mapper.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(model).toSet();
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertSet(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<OrderDTO>() ||
            sourceTypeOf == _typeOf<OrderDTO?>()) &&
        (targetTypeOf == _typeOf<OrderEntity>() ||
            targetTypeOf == _typeOf<OrderEntity?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__OrderDTO__To__OrderEntity((model as OrderDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<OrderEntity>() ||
            sourceTypeOf == _typeOf<OrderEntity?>()) &&
        (targetTypeOf == _typeOf<OrderDTO>() ||
            targetTypeOf == _typeOf<OrderDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__OrderEntity__To__OrderDTO((model as OrderEntity?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  OrderEntity _map__OrderDTO__To__OrderEntity(OrderDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping OrderDTO → OrderEntity failed because OrderDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<OrderDTO, OrderEntity> to handle null values during mapping.');
    }
    return OrderEntity(
      id: model.id,
      createdBy: OrderMapper.createdByToEntity(model),
      orderNumber: model.orderNumber,
      createdAt: model.createdAt,
      status: model.status,
      paymentMethod: model.paymentMethod,
      totalQty: model.totalQty,
      amountDownPayment: model.amountDownPayment,
      total: model.total,
      profit: model.profit,
      updatedBy: OrderMapper.updatedByToEntity(model),
      updatedAt: model.updatedAt,
      customer: OrderMapper.customerToEntity(model),
      cloths: OrderMapper.listClothToEntity(model),
      orderPaymentLog: OrderMapper.listOrderPaymentLogToEntity(model),
      orderHistoryLog: OrderMapper.listOrderHistoryLogToEntity(model),
    );
  }

  OrderDTO _map__OrderEntity__To__OrderDTO(OrderEntity? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping OrderEntity → OrderDTO failed because OrderEntity was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<OrderEntity, OrderDTO> to handle null values during mapping.');
    }
    return OrderDTO(
      id: model.id,
      createdBy: OrderMapper.createdByToDto(model),
      orderNumber: model.orderNumber,
      createdAt: model.createdAt,
      status: model.status,
      paymentMethod: model.paymentMethod,
      totalQty: model.totalQty,
      amountDownPayment: model.amountDownPayment,
      total: model.total,
      profit: model.profit,
      cloths: OrderMapper.listClothToDto(model),
      updatedBy: OrderMapper.updatedByToDTO(model),
      updatedAt: model.updatedAt,
      customer: OrderMapper.customerToDto(model),
      orderHistoryLog: OrderMapper.listOrderHistoryLogToDto(model),
      orderPaymentLog: OrderMapper.listOrderPaymentLogToDTO(model),
    );
  }
}
