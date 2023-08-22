import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/customer_type_dto.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';

part 'customer_type_mapper.g.dart';

@AutoMappr([
  MapType<CustomerTypeDTO, CustomerTypeEntity>(),
  MapType<CustomerTypeEntity, CustomerTypeDTO>()
])
class CustomerTypeMapper extends $CustomerTypeMapper {}