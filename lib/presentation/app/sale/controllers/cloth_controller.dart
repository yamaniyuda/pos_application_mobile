import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'dart:async';
import 'package:pos_application_mobile/domain/use_cases/cloth/cloth.dart' as ClothUseCase;
import 'package:pos_application_mobile/presentation/app/sale/model/cloth_form_payload.dart';

class ClothController extends GetxController {
  late ClothUseCase.FetchDataUseCase _fetchDataUseCase;

  /// List of fetched data.
  final RxList<ClothFormPayload> _data = <ClothFormPayload>[].obs;
  List<ClothFormPayload> get data => _data;

  /// Detail of fetch data cloth.
  late final Rx<ClothEntity>? _dataDetail;
  ClothEntity? get dataDetail => _dataDetail?.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  ///  current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  ///  total pagination state
  final Rx<int> _totalPage = 0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search
  Timer? _debonce;

  @override
  void onInit() {
    _fetchDataUseCase = ClothUseCase.FetchDataUseCase();
    fetchData();
    super.onInit();
  }

  void updateItems(
      {required ClothFormPayload payload,
      required String clothColorId,
      required String clothSizeId,
      required String clothSizePriceId,
      required int qyt,
      bool reset = false}) {
      payload.updateItems(
          clothColorId: clothColorId,
          clothSizeId: clothSizeId,
          clothSizePriceId: clothSizePriceId,
          qty: qyt,
          reset: reset);

    update();
  }
  
  
  Map<String, Map<String, dynamic>> getAllItems() {
    final Map<String, Map<String, dynamic>> itemAll = {};

    for (var element in _data) { 
      if (element.items.isNotEmpty) {
        itemAll.addAll(element.items);
      }
    }
    return itemAll;
  }

  /// Clear Data
  ///
  /// The `clearData` usage for handling data clear when screen
  /// on reload for refresh screen.
  void clearData(List<ClothEntity> clothEntities) {
    _totalPage.value = 0;
    _currentPage.value = 1;

    if (clothEntities.isNotEmpty) {
      Map dataItems = _getItemsChoose();
      _updateData(clothEntities);
    }
  }


  /// Retrieves a nested map of items based on certain criteria.
  ///
  /// This function iterates through a data source, extracts items that meet
  /// specific criteria, and returns a nested map containing these items.
  ///
  /// Returns:
  ///   A map with the type `Map<String, Map<String, int>>` representing the
  ///   selected items.
  Map<String, Map<String, int>> _getItemsChoose() {
    Iterable dataItemsIterable =
        _data.expand<Map<String, dynamic>>((element) sync* {
      if (element.items.isNotEmpty) {
        yield {element.clothEntity.id!: element.items};
      }
    });

    Map<String, Map<String, int>> dataItemsMap = Map.fromIterable(
      dataItemsIterable,
    );

    return dataItemsMap;
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
  Future<void> fetchData(
      {bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Check if we have reached the total number of pages
    if (_currentPage.value == _totalPage.value) return;

    // Build query parameters for the request
    Map<String, dynamic> buildQueryParameters = {
      "order": "name",
      "ascending": 1,
      "use_detail_cloth": 1,
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
    List<ClothEntity> data = await _fetchDataUseCase.call(buildQueryParameters);

    if (refresh) {
      // Clear data if refreshing
      clearData(data);
    } else {
      // Update state with fetched data
      _updateData(data);
    }

    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }


  /// Updates the `_data` list with new [ClothEntity] objects.
  ///
  /// This function takes a list of [ClothEntity] objects and adds them to the
  /// `_data` list. Each [ClothEntity] is encapsulated in a [ClothFormPayload]
  /// instance with an empty `items` map.
  ///
  /// Parameters:
  ///   - clothEntity: A list of [ClothEntity] objects to be added to the `_data` list.
  void _updateData(List<ClothEntity> clothEntity) {
    for (var element in clothEntity) {
      _data.add(ClothFormPayload(items: {}, clothEntity: element));
    }
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
      fetchData(refresh: true, queryParameters: {"name": value});
    });
  }
}
