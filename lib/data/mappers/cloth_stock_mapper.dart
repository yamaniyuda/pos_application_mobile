import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_color_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_stock_dto.dart';
import 'package:pos_application_mobile/data/dtos/size_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_color_mapper.dart';
import 'package:pos_application_mobile/data/mappers/size_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_stock_entity.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';


part 'cloth_stock_mapper.g.dart';

@AutoMappr([
  MapType<ClothStockDTO, ClothStockEntity>(
    fields: [
      Field('clothColor', custom: ClothStockMapper.clothColorToEntity),
      Field('size', custom: ClothStockMapper.sizeToEntity),
    ]
  ),
  MapType<ClothStockEntity, ClothStockDTO>(
    fields: [
      Field('clothColor', custom: ClothStockMapper.clothClorToDTO),
      Field('size', custom: ClothStockMapper.sizeToDTO),
    ]
  ),
])
class ClothStockMapper extends $ClothStockMapper {
  static ClothColorEntity? clothColorToEntity(ClothStockDTO dto) {
    return ClothColorMapper().tryConvert<ClothColorDTO, ClothColorEntity>(dto.clothColor);
  }

  static ClothColorDTO? clothClorToDTO(ClothStockEntity entity) {
    return ClothColorMapper().tryConvert<ClothColorEntity, ClothColorDTO>(entity.clothColor);
  }

  static SizeEntity? sizeToEntity(ClothStockDTO dto) {
    return SizeMapper().tryConvert<SizeDTO, SizeEntity>(dto.size);
  }

  static SizeDTO? sizeToDTO(ClothStockEntity entity) {
    return SizeMapper().tryConvert<SizeEntity, SizeDTO>(entity.size);
  }
}