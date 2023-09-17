// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/customer_type/customer_type.dart' as CustomerType;

class CustomerChooseController extends GetxController {
  late CustomerType.FetchDataUseCase fetchDataUseCaseCustomerType;

  final RxList<CustomerTypeEntity> _dataCustomerType = <CustomerTypeEntity>[].obs;
  List<CustomerTypeEntity> get dataCustomerType => _dataCustomerType.value;

  /// loading state for handling fetching state conditional ui
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxString _chooseValue = "".obs;
  String get chooseValue => _chooseValue.value; 
  
  final RxString _chooseLabel = "".obs;
  String get chooseLabel => _chooseLabel.value;

  @override
  void onInit() async {
    fetchDataUseCaseCustomerType = CustomerType.FetchDataUseCase();
    await fetchDataHandling();
    super.onInit();
  }


  /// Change radio selection handler
  /// 
  /// The `changeRadioSelection` function is function handler for change
  /// choosing value from options
  /// 
  /// Parameters:
  /// - `value`: A string value
  void changeRadioSection(String value, String name) {
    _chooseValue.value = value;
    _chooseLabel.value = name;
  }

  Future<void> fetchDataHandling() async {
    _isLoading.value = true;
    List<CustomerTypeEntity> data = await CustomerType.FetchDataUseCase().call();
    _dataCustomerType.addAll(data);
    _isLoading.value = false;
  }
}