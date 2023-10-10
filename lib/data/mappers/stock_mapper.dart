import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_stock_dto.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/stock_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_stock_mapper.dart';
import 'package:pos_application_mobile/data/mappers/created_by_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_stock_entity.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';

part 'stock_mapper.g.dart';
@AutoMappr([
  MapType<StockDTO, StockEntity>(),
  MapType<StockEntity, StockDTO>()
])
class StockMapper extends $StockMapper {
    
  static CreatedByEntity? createdByToEntity(StockDTO dto) {
    return CreatedByMapper().tryConvert<CreatedByDTO, CreatedByEntity>(dto.createdBy);
  }

  static CreatedByDTO? createdByToDTO(StockEntity entity) {
    return CreatedByMapper().tryConvert<CreatedByEntity, CreatedByDTO>(entity.createdBy);
  }

  static ClothStockEntity? clothStockToEntity(StockDTO dto) {
    return ClothStockMapper().tryConvert<ClothStockDTO, ClothStockEntity>(dto.clothStock);
  }

  static ClothStockDTO? clothStockToDTO(StockEntity entity) {
    return ClothStockMapper().tryConvert<ClothStockEntity, ClothStockDTO>(entity.clothStock);
  }
}