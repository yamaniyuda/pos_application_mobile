import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/auth_dto.dart';
import 'package:pos_application_mobile/domain/entities/auth_entity.dart';

part 'auth_mapper.g.dart';
@AutoMappr([
  MapType<AuthDTO, AuthEntity>(),
  MapType<AuthEntity, AuthDTO>()
])
class AuthMapper extends $AuthMapper {}