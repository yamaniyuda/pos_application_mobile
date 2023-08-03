import 'package:pos_application_mobile/app/services/api/dio_client.dart';

/// abstract class for remote data source
/// like init dio client
abstract class RemoteDataSource {
  final DioClient _dioClient;

  RemoteDataSource(): _dioClient = DioClient.init();
  DioClient get dioClient => _dioClient;
}