import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/supplier_dto.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';

part 'supplier_mapper.g.dart';
@AutoMappr([
  MapType<SupplierDTO, SupplierEntity>(),
  MapType<SupplierEntity, SupplierDTO>()
])
class SupplierMapper extends $SupplierMapper {}