import 'package:pos_application_mobile/data/dtos/customer_dto.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'customer_mapper.g.dart';

@AutoMappr([
  MapType<CustomerDTO, CustomerEntity>(),
  MapType<CustomerEntity, CustomerDTO>()
])
class CustomerMapper extends $CustomerMapper {}