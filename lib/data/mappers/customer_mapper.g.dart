// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_mapper.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template package:pos_application_mobile/data/mappers/customer_mapper.dart}
/// Available mappings:
/// - `CustomerDTO` → `CustomerEntity`.
/// - `CustomerEntity` → `CustomerDTO`.
/// {@endtemplate}
class $CustomerMapper implements AutoMapprInterface {
  const $CustomerMapper();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<CustomerDTO>() ||
            sourceTypeOf == _typeOf<CustomerDTO?>()) &&
        (targetTypeOf == _typeOf<CustomerEntity>() ||
            targetTypeOf == _typeOf<CustomerEntity?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<CustomerEntity>() ||
            sourceTypeOf == _typeOf<CustomerEntity?>()) &&
        (targetTypeOf == _typeOf<CustomerDTO>() ||
            targetTypeOf == _typeOf<CustomerDTO?>())) {
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/customer_mapper.dart}
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
    if ((sourceTypeOf == _typeOf<CustomerDTO>() ||
            sourceTypeOf == _typeOf<CustomerDTO?>()) &&
        (targetTypeOf == _typeOf<CustomerEntity>() ||
            targetTypeOf == _typeOf<CustomerEntity?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__CustomerDTO__To__CustomerEntity((model as CustomerDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<CustomerEntity>() ||
            sourceTypeOf == _typeOf<CustomerEntity?>()) &&
        (targetTypeOf == _typeOf<CustomerDTO>() ||
            targetTypeOf == _typeOf<CustomerDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__CustomerEntity__To__CustomerDTO((model as CustomerEntity?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  CustomerEntity _map__CustomerDTO__To__CustomerEntity(CustomerDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping CustomerDTO → CustomerEntity failed because CustomerDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<CustomerDTO, CustomerEntity> to handle null values during mapping.');
    }
    return CustomerEntity(
      address: model.address,
      createdAt: model.createdAt,
      customerCategoryId: model.customerCategoryId,
      districtId: model.districtId,
      email: model.email,
      id: model.id,
      name: model.name,
      phoneNumber: model.phoneNumber,
      provinceId: model.provinceId,
      regencyId: model.regencyId,
      villageId: model.villageId,
    );
  }

  CustomerDTO _map__CustomerEntity__To__CustomerDTO(CustomerEntity? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping CustomerEntity → CustomerDTO failed because CustomerEntity was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<CustomerEntity, CustomerDTO> to handle null values during mapping.');
    }
    return CustomerDTO(
      address: model.address,
      createdAt: model.createdAt,
      customerCategoryId: model.customerCategoryId,
      districtId: model.districtId,
      email: model.email,
      id: model.id,
      name: model.name,
      phoneNumber: model.phoneNumber,
      provinceId: model.provinceId,
      regencyId: model.regencyId,
      villageId: model.villageId,
    );
  }
}
