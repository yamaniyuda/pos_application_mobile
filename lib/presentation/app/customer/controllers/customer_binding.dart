// ignore_for_file: library_prefixes

import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/use_cases/customer_type/fetch_data_use_case.dart';
import 'package:pos_application_mobile/presentation/app/customer/customer.dart';
import 'package:pos_application_mobile/domain/use_cases/provincy/fetch_data_use_case.dart' as Provincy;
import 'package:pos_application_mobile/domain/use_cases/regency/fetch_data_use_case.dart' as Regency;
import 'package:pos_application_mobile/domain/use_cases/district/fetch_data_use_case.dart' as District;
import 'package:pos_application_mobile/domain/use_cases/village/fetch_data_use_case.dart' as Village;

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FetchDataUseCase(), tag: 'customerType');
    Get.put(Regency.FetchDataUseCase(), tag: 'regency');
    Get.put(District.FetchDataUseCase(), tag: 'district');
    Get.put(Village.FetchDataUseCase(), tag: 'village');
    Get.put(Provincy.FetchDataUseCase(), tag: 'provincy');
    Get.put(CustomerController());
  }
}