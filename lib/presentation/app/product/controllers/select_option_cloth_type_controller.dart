// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth_category/fetch_data_use_case.dart';

class SelectOptionClothTypeController extends GetxController {
  /// Inject depedency for fetch data customer type
  final FetchDataUseCase fetchData = Get.put(FetchDataUseCase(), tag: "fetch-cloth-type");

  /// List data customer type
  final RxList<ClothCategoryEntity> _customerTypeDatas = <ClothCategoryEntity>[].obs;
  List<ClothCategoryEntity> get customerTypeDatas => _customerTypeDatas.value;

  /// loading state for handling fetching state conditional ui
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// state for handling choose category
  final RxString _chooseValue = "".obs;
  String get chooseValue => _chooseValue.value;

  /// state for handling labe
  final RxString _chooseLabel = "".obs;
  String get chooseLabel => _chooseLabel.value;

  @override
  void onInit() {
    fetchDataHandling();
    super.onInit();
  }

  /// Change radio selection handler
  /// 
  /// The `changeRadioSelection` function is function handler for change
  /// choosing value from options
  /// 
  /// Parameters:
  /// - `value`: A string value
  void changeRadioSelection(String value, String name) {
    _chooseValue.value = value;
    _chooseLabel.value = name;
  }

  /// Fetches Customer data from a remote data source.
  ///
  /// The `fetchDataHandling` function is responsible for fetching data from a remote
  /// data source. 
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchDataHandling({Map<String, dynamic>? queryParameters}) async {
    // Build query parameters for the request
    Map<String, dynamic> buildQueryParameters = {
      "order": "name",
      "ascending": 1,
      "page": 1,
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
    List<ClothCategoryEntity> data = await fetchData.call(buildQueryParameters);

    // Update state with fetched data
    _customerTypeDatas.value.addAll(data);
    _isLoading.value = false;
  }
}