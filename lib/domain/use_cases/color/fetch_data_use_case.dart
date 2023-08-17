import 'package:pos_application_mobile/data/repositories/color_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/repositories/color_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<ColorRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(ColorRepositoryImpl());

  @override
  Future<List<ColorEntity>> call([Map<String, dynamic>? params]) async {
    final List<ColorEntity> data = await repository.fetchData(params);
    return data;
  }
}