import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/district_dto.dart';
import 'package:pos_application_mobile/data/dtos/provincy_dto.dart';
import 'package:pos_application_mobile/data/dtos/regency_dto.dart';
import 'package:pos_application_mobile/data/dtos/supplier_dto.dart';
import 'package:pos_application_mobile/data/dtos/village_dto.dart';
import 'package:pos_application_mobile/data/mappers/district_mapper.dart';
import 'package:pos_application_mobile/data/mappers/provincy_mapper.dart';
import 'package:pos_application_mobile/data/mappers/regency_mapper.dart';
import 'package:pos_application_mobile/data/mappers/village_mapper.dart';
import 'package:pos_application_mobile/domain/entities/district_entity.dart';
import 'package:pos_application_mobile/domain/entities/provincy_entity.dart';
import 'package:pos_application_mobile/domain/entities/regency_entity.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';
import 'package:pos_application_mobile/domain/entities/village_entity.dart';

part 'supplier_mapper.g.dart';
@AutoMappr([
  MapType<SupplierDTO, SupplierEntity>(
    fields: [
      Field('province', custom: SupplierMapper.provincyDtoToEntity),
      Field('regency', custom: SupplierMapper.regencyDtoToEntity),
      Field('district', custom: SupplierMapper.districtDtoToEntity),
      Field('village', custom: SupplierMapper.villageDtoToEntity)
    ]
  ),
  MapType<SupplierEntity, SupplierDTO>(
    fields: [
      Field('province', custom: SupplierMapper.provincyEntityToDto),
      Field('regency', custom: SupplierMapper.regencyEntityToDto),
      Field('district', custom: SupplierMapper.districtEntityToDto),
      Field('village', custom: SupplierMapper.villageEntityToDto)
    ]
  )
])
class SupplierMapper extends $SupplierMapper {
  static ProvincyEntity? provincyDtoToEntity(SupplierDTO dto) {
    return ProvincyMapper().tryConvert<ProvincyDTO, ProvincyEntity>(dto.province);
  }

  static ProvincyDTO? provincyEntityToDto(SupplierEntity entity) {
    return ProvincyMapper().tryConvert<ProvincyEntity, ProvincyDTO>(entity.province);
  }
  
  static RegencyEntity? regencyDtoToEntity(SupplierDTO dto) {
    return RegencyMapper().tryConvert<RegencyDTO, RegencyEntity>(dto.regency);
  }

  static RegencyDTO? regencyEntityToDto(SupplierEntity entity) {
    return RegencyMapper().tryConvert<RegencyEntity, RegencyDTO>(entity.regency);
  }

  static DistrictEntity? districtDtoToEntity(SupplierDTO dto) {
    return DistrictMapper().tryConvert<DistrictDTO, DistrictEntity>(dto.district);
  }

  static DistrictDTO? districtEntityToDto(SupplierEntity entity) {
    return DistrictMapper().tryConvert<DistrictEntity, DistrictDTO>(entity.district);
  }

  static VillageEntity? villageDtoToEntity(SupplierDTO dto) {
    return VillageMapper().tryConvert<VillageDTO, VillageEntity>(dto.village);
  }

  static VillageDTO? villageEntityToDto(SupplierEntity entity) {
    return VillageMapper().tryConvert<VillageEntity, VillageDTO>(entity.village);
  }
}