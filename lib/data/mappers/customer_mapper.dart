// ignore_for_file: depend_on_referenced_packages

import 'package:pos_application_mobile/data/dtos/customer_dto.dart';
import 'package:pos_application_mobile/data/dtos/customer_type_dto.dart';
import 'package:pos_application_mobile/data/dtos/district_dto.dart';
import 'package:pos_application_mobile/data/dtos/provincy_dto.dart';
import 'package:pos_application_mobile/data/dtos/regency_dto.dart';
import 'package:pos_application_mobile/data/dtos/village_dto.dart';
import 'package:pos_application_mobile/data/mappers/customer_type_mapper.dart';
import 'package:pos_application_mobile/data/mappers/district_mapper.dart';
import 'package:pos_application_mobile/data/mappers/provincy_mapper.dart';
import 'package:pos_application_mobile/data/mappers/regency_mapper.dart';
import 'package:pos_application_mobile/data/mappers/village_mapper.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/entities/district_entity.dart';
import 'package:pos_application_mobile/domain/entities/provincy_entity.dart';
import 'package:pos_application_mobile/domain/entities/regency_entity.dart';
import 'package:pos_application_mobile/domain/entities/village_entity.dart';

part 'customer_mapper.g.dart';

@AutoMappr([
  MapType<CustomerDTO, CustomerEntity>(
    fields: [
      Field('customerType', custom: CustomerMapper.customerTypeDtoToEntity),
      Field('province', custom: CustomerMapper.provincyDtoToEntity),
      Field('regency', custom: CustomerMapper.regencyDtoToEntity),
      Field('district', custom: CustomerMapper.districtDtoToEntity),
      Field('village', custom: CustomerMapper.villageDtoToEntity)
    ]
  ),
  MapType<CustomerEntity, CustomerDTO>(
    fields: [
      Field('customerType', custom: CustomerMapper.customerTypeEntityToDto),
      Field('province', custom: CustomerMapper.provincyEntityToDto),
      Field('regency', custom: CustomerMapper.regencyEntityToDto),
      Field('district', custom: CustomerMapper.districtEntityToDto),
      Field('village', custom: CustomerMapper.villageEntityToDto)
    ]
  )
])
class CustomerMapper extends $CustomerMapper {
  static CustomerTypeEntity? customerTypeDtoToEntity(CustomerDTO dto) {
    return CustomerTypeMapper().tryConvert<CustomerTypeDTO, CustomerTypeEntity>(dto.customerType);
  }

  static CustomerTypeDTO? customerTypeEntityToDto(CustomerEntity entity) {
    return CustomerTypeMapper().tryConvert<CustomerTypeEntity, CustomerTypeDTO>(entity.customerType);
  }

  static ProvincyEntity? provincyDtoToEntity(CustomerDTO dto) {
    return ProvincyMapper().tryConvert<ProvincyDTO, ProvincyEntity>(dto.province);
  }

  static ProvincyDTO? provincyEntityToDto(CustomerEntity entity) {
    return ProvincyMapper().tryConvert<ProvincyEntity, ProvincyDTO>(entity.province);
  }
  
  static RegencyEntity? regencyDtoToEntity(CustomerDTO dto) {
    return RegencyMapper().tryConvert<RegencyDTO, RegencyEntity>(dto.regency);
  }

  static RegencyDTO? regencyEntityToDto(CustomerEntity entity) {
    return RegencyMapper().tryConvert<RegencyEntity, RegencyDTO>(entity.regency);
  }

  static DistrictEntity? districtDtoToEntity(CustomerDTO dto) {
    return DistrictMapper().tryConvert<DistrictDTO, DistrictEntity>(dto.district);
  }

  static DistrictDTO? districtEntityToDto(CustomerEntity entity) {
    return DistrictMapper().tryConvert<DistrictEntity, DistrictDTO>(entity.district);
  }

  static VillageEntity? villageDtoToEntity(CustomerDTO dto) {
    return VillageMapper().tryConvert<VillageDTO, VillageEntity>(dto.village);
  }

  static VillageDTO? villageEntityToDto(CustomerEntity entity) {
    return VillageMapper().tryConvert<VillageEntity, VillageDTO>(entity.village);
  }
}