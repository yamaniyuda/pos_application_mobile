// ignore_for_file: library_prefixes

import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/use_cases/provincy/fetch_data_use_case.dart' as Provincy;
import 'package:pos_application_mobile/domain/use_cases/regency/fetch_data_use_case.dart' as Regency;
import 'package:pos_application_mobile/domain/use_cases/district/fetch_data_use_case.dart' as District;
import 'package:pos_application_mobile/domain/use_cases/village/fetch_data_use_case.dart' as Village;
import 'package:pos_application_mobile/presentation/app/supplier/supplier.dart';

class SupplierBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Regency.FetchDataUseCase(), tag: 'regency');
    Get.put(District.FetchDataUseCase(), tag: 'district');
    Get.put(Village.FetchDataUseCase(), tag: 'village');
    Get.put(Provincy.FetchDataUseCase(), tag: 'provincy');
    Get.put(SupplierController());
  }
}