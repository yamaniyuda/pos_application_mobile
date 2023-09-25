import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_price_type_dto.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';

part 'cloth_price_type_mapper.g.dart';
@AutoMappr([
  MapType<ClothPriceTypeDTO, ClothPriceTypeEntity>(),
  MapType<ClothPriceTypeEntity, ClothPriceTypeDTO>()
])
class ClothPriceTypeMapper extends $ClothPriceTypeMapper {}