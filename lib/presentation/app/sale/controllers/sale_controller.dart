// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/order/fetch_data_use_case.dart';

/// Controller responsible for managing -related operations.
class SaleController extends GetxController with GetSingleTickerProviderStateMixin {
  /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();

  /// Fetch data use case instance for  data.
  late FetchDataUseCase fetchDataUseCase;

  /// List of fetched data.
  final RxList<OrderEntity> _data = <OrderEntity>[].obs;
  List<OrderEntity> get data => _data.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  ///  current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  ///  total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search 
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  /// tab controller for tab in screen
  late TabController _tabController;
  TabController get tabController => _tabController;

  @override
  void onInit() {
    fetchDataUseCase = FetchDataUseCase();
    fetchData();
    _showSupperAccess.value = [AuthService.OWNER].contains(
      authService.userEntity?.role
    );
    _tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    _debonce?.cancel();
    super.onClose();
  }

  /// do clear data 
  void clearData() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _data.value = [];
  }

  /// Search data ustomer handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchData)
  /// ```
  void searchData(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchData(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches data from a remote data source.
  ///
  /// The `fetchData` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [data] to manage the pagination and loading of  data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchData({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearData();

    // Check if we have reached the total number of pages
    if (_currentPage.value == _totalPage.value) return;

    // Build query parameters for the request
    Map<String, dynamic> buildQueryParameters = {
      "ascending": 1,
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

    // Fetch data using the  data use case
    List<OrderEntity> data = await fetchDataUseCase.call(buildQueryParameters);

    // Update state with fetched data
    _data.value.addAll(data);
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
