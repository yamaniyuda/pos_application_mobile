// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/customer/fetch_data_use_case.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
/// Controller responsible for managing Customer-related operations.
class CustomerSearchController extends GetxController {
  /// Get form controller.
  final SaleFormController saleFormController = Get.find<SaleFormController>();

  /// Fetch data use case instance for Customer data.
  late FetchDataUseCase fetchDataUseCaseCustomer;

  /// List of fetched Customer data.
  final RxList<CustomerEntity> _dataCustomer = <CustomerEntity>[].obs;
  List<CustomerEntity> get dataCustomer => _dataCustomer.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Customer current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// Customer total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search Customer
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchDataUseCaseCustomer = FetchDataUseCase();
    ever(saleFormController.customerTypePayloadRx, (callback) => fetchDataCustomer(refresh: true));
    fetchDataCustomer(refresh: true);
    super.onInit();
  }

  @override
  void onClose() {
    _debonce?.cancel();
    super.onClose();
  }

  /// do clear data Customer
  void clearDataCustomer() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataCustomer.value = [];
  }

  /// Search data ustomer handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchDataCustomer)
  /// ```
  void searchDataCustomer(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchDataCustomer(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches Customer data from a remote data source.
  ///
  /// The `fetchDataCustomer` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [dataCustomers] to manage the pagination and loading of Customer data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchDataCustomer({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearDataCustomer();

    // Check if we have reached the total number of pages
    if (_currentPage.value == _totalPage.value) return;

    // Build query parameters for the request
    Map<String, dynamic> buildQueryParameters = {
      "order": "name",
      "ascending": 1,
      "customer_category_id": saleFormController.customerTypePayload["value"],
      "page": _currentPage.value,
    };

    // Merge additional query parameters if provided
    if (queryParameters != null) {
      buildQueryParameters = {
        ...buildQueryParameters,
        ...queryParameters,
      };
    }

    // Set loading state
    _isLoading.value = true;

    // Fetch data using the Customer data use case
    List<CustomerEntity> data = await fetchDataUseCaseCustomer.call(buildQueryParameters);

    // Update state with fetched data
    _dataCustomer.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }
}
