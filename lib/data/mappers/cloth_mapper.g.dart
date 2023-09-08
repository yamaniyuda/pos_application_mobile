// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_mapper.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template package:pos_application_mobile/data/mappers/cloth_mapper.dart}
/// Available mappings:
/// - `ClothDTO` → `ClothEntity`.
/// - `ClothEntity` → `ClothDTO`.
/// {@endtemplate}
class $ClothMapper implements AutoMapprInterface {
  const $ClothMapper();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<ClothDTO>() ||
            sourceTypeOf == _typeOf<ClothDTO?>()) &&
        (targetTypeOf == _typeOf<ClothEntity>() ||
            targetTypeOf == _typeOf<ClothEntity?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<ClothEntity>() ||
            sourceTypeOf == _typeOf<ClothEntity?>()) &&
        (targetTypeOf == _typeOf<ClothDTO>() ||
            targetTypeOf == _typeOf<ClothDTO?>())) {
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
  /// {@macro package:pos_application_mobile/data/mappers/cloth_mapper.dart}
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
    if ((sourceTypeOf == _typeOf<ClothDTO>() ||
            sourceTypeOf == _typeOf<ClothDTO?>()) &&
        (targetTypeOf == _typeOf<ClothEntity>() ||
            targetTypeOf == _typeOf<ClothEntity?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__ClothDTO__To__ClothEntity((model as ClothDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<ClothEntity>() ||
            sourceTypeOf == _typeOf<ClothEntity?>()) &&
        (targetTypeOf == _typeOf<ClothDTO>() ||
            targetTypeOf == _typeOf<ClothDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__ClothEntity__To__ClothDTO((model as ClothEntity?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  ClothEntity _map__ClothDTO__To__ClothEntity(ClothDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ClothDTO → ClothEntity failed because ClothDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ClothDTO, ClothEntity> to handle null values during mapping.');
    }
    return ClothEntity(
      clothCategory: ClothMapper.clothCategoryDtoToEntity(model),
      clothColors: ClothMapper.listClothColorDtoToEntity(model),
      createdAt: model.createdAt,
      createdBy: ClothMapper.createdByDtoToEntity(model),
      id: model.id,
      status: model.status,
      updatedBy: ClothMapper.updatedByDtoToEntity(model),
    );
  }

  ClothDTO _map__ClothEntity__To__ClothDTO(ClothEntity? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ClothEntity → ClothDTO failed because ClothEntity was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ClothEntity, ClothDTO> to handle null values during mapping.');
    }
    return ClothDTO(
      clothCategory: ClothMapper.clothCategoryEntityToDto(model),
      clothColors: ClothMapper.listClothColorEntityToDTO(model),
      createdAt: model.createdAt,
      createdBy: ClothMapper.createdByEntityToDto(model),
      id: model.id,
      status: model.status,
      updatedBy: ClothMapper.updatedByEntityToDto(model),
    );
  }
}
