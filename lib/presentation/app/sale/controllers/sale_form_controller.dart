// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:get/get.dart';
import 'package:pos_application_mobile/data/payloads/order_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/cloth.dart';

class SaleFormController extends GetxController {
  /// Data customer type which not show input customer name.
  static const List<String> customerTypeWithoutName = ['shopee', 'tiktok'];
  static const List<String> paymentMethodOptions = ["cash", "down payment"];
  

  late FetchBySkuUseCase _fetchBySkuUseCase;


  /// The `isLoading` state usage for handling UI loading indicator, and will
  /// stop after the data succesfully retrieved on the server.
  final RxBool isLoading = true.obs;


  /// The `customerTypePayload` usage for storing data input for fieldE
  /// search customer type. This variabel(payload) will update when input change.
  /// 
  /// Struck: 
  /// - `label`: id of custoemr type.
  /// - `value`: name of customer type.
  final RxMap _customerTypePayload = {}.obs;
  Map get customerTypePayload => _customerTypePayload.value;
  RxMap get customerTypePayloadRx => _customerTypePayload;

  
  /// The `customerPayloadId` usage for place for storing data input for customer id
  /// if customer cateogry is not the same as `shopeee` and `tiktok`.
  final RxString _customerPayloadId = "".obs;
  String get customerPayloadId => _customerPayloadId.value;


  /// The `_paymentMethod` usage for place for storing data input for payment  method  
  final RxString _paymentMethod = "".obs;
  String get paymentMethod => _paymentMethod.value;

  /// The `_clothColorPayload` usage for place for storing data input for field
  /// cloth color.
  final RxList<ClothColorEntity> _clothColorPayload = <ClothColorEntity>[].obs;
  List<ClothColorEntity> get clothColorPayload => _clothColorPayload;


  /// The `_amountPaymentMethod` usage for place for storing amount data input for
  /// field amount down payment.
  final RxString _amountPaymentMethod = "".obs;
  String get amountPaymentMethod => _amountPaymentMethod.value;


  /// The `_orderDetails` usage for place for stroing data input from cloth
  final RxMap<String, dynamic> _orderDetails = <String, dynamic>{}.obs;
  Map<String, dynamic> get orderDetails => _orderDetails.value;


  /// The `_debounce` variabel for handling input chnage with debounce time.
  Timer? _debounce;

  final RxBool isLoadingClothSearch = false.obs;

  @override
  void onInit() {
    _fetchBySkuUseCase = FetchBySkuUseCase();
    addClothColorPayload();
    super.onInit();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
  

  Future<bool> searchClothColorBySku(String sku, int index) async {
    late bool result = false;

    isLoadingClothSearch.value = true;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () async {
      try {
        ClothColorEntity respone = await _fetchBySkuUseCase.call(
          FetchBySkuUseCaseParams(
            sku: sku,
            customerCategoryId: _customerTypePayload.value["value"]
          )
        );
        _clothColorPayload[index] = respone;
        _clothColorPayload.refresh();
        addOrderDetails(index);
        result = true;
      } catch(e) {
        result = false;
      }
    });

    isLoadingClothSearch.value = false;

    return result;
  }


  void changeAmountDownPaymentHandler(String value) {
    _amountPaymentMethod.value = value;
  }


  /// Add Order Details.
  /// 
  /// The `addOrderDetails` usage for handling add order details.
  void addOrderDetails(int indexSKU) {
    for (var i = 0; i < _clothColorPayload[indexSKU].clothSizes!.length; i++) {
      _orderDetails.addAll({"$indexSKU$i": OrderDetailPayload(
        clothSizeId: _clothColorPayload.value[indexSKU].clothSizes![i].id!,
        clothSizePriceId: _clothColorPayload.value[indexSKU].clothSizes![i].price!.id!, 
        qyt: 0
      )});
    }
  }



  void deleteClothColorPayload(int indexSku) {
    if (indexSku < 0 || indexSku >= _clothColorPayload.length) {
      return; // Index is out of bounds, handle error or return early.
    }

    // Remove the clothColorPayload at the specified index
    _clothColorPayload.removeAt(indexSku);

    List<ClothColorEntity> clothColorBackUp = [];
    clothColorBackUp = List.from(clothColorPayload);
    _clothColorPayload.removeRange(0, _clothColorPayload.length);

    // Remove associated _orderDetails entries
    List<String> keysToRemove = _orderDetails.keys
        .where((key) => key.startsWith('$indexSku'))
        .toList();

    for (String key in keysToRemove) {
      _orderDetails.remove(key);
    }

    // Shift the remaining keys to match the updated indices
    List<String> updatedKeys = [];
    for (String key in _orderDetails.keys) {
      List<String> parts = key.split('');
      int oldIndexSku = int.parse(parts[0]);
      int newIndexSku = oldIndexSku > indexSku ? oldIndexSku - 1 : oldIndexSku;
      String newIndex = newIndexSku.toString() + parts[1];
      updatedKeys.add(newIndex);
    }

    late int newKeyMapOrderDetail = 0;

    // Update the keys in _orderDetails
    Map<String, dynamic> updatedOrderDetails = Map.fromEntries(
      _orderDetails.entries.map((entry) {
        final newMap = MapEntry(updatedKeys[newKeyMapOrderDetail], entry.value);
        newKeyMapOrderDetail += 1;
        return newMap;
      }),
    );
    _orderDetails.clear();
    _orderDetails.addAll(updatedOrderDetails);

    // Ensure that the _clothColorPayload and _orderDetails are refreshed
    addClothColorPayloadAddHandler(clothColorBackUp);
    _orderDetails.refresh();
  }


  Future<void> addClothColorPayloadAddHandler(List<ClothColorEntity> clothColorBackUp) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _clothColorPayload.addAll(clothColorBackUp);
    _clothColorPayload.refresh();
  }


  /// Add Cloth Color Payload.
  /// 
  /// The `clothColorPayload` usage for handling add new value in
  /// list `_clothColorPayload`. 
  void addClothColorPayload() {
    _clothColorPayload.add(
      ClothColorEntity()
    );
  }


  OrderPayload orderPayloadBuilder() {
    return OrderPayload(
      paymentMethod: _paymentMethod.value, 
      amountDownPayment: _amountPaymentMethod.value, 
      customerCategory: _customerTypePayload.value["label"], 
      customerId: _customerPayloadId.value, 
      orderDetails: List.from(
        _orderDetails.entries.map((e) => e.value)
      )
    );
  }


  /// Change Quantity.
  /// 
  /// The `changeQuantity` usage for handling chnage data queantity in
  /// `_orderDetials` with  update new value.
  /// 
  /// Params:
  /// - `quantity`: total quantity from input field.
  /// - `indexSKU`: index value for reprentation index from `_clothColorPayload`.
  /// - `indexDetail`: index value for repretation index from `_orderDetails`
  void changeQuantity(int quantity, int indexSKU, int indexDetail) {
    _orderDetails["$indexSKU$indexDetail"].qyt = quantity;
  }


  /// Chnage Customer Type Payload.
  /// 
  /// The `changeCustomerTypePayload` function will handling chnage data for
  /// property `_customerPayloadId`.
  void changeCustomerTypePayload(String value, String label) {
    _customerTypePayload.value = {
      "label": label,
      "value": value
    };
  }


  /// Get Height App Bar.
  /// 
  /// The `getHeightAppBar` will return height after calculate
  /// showing input addtional or not.
  double getHeightAppBar() {
    late int height = 220;

    if (isShowInputChooseCustomer(customerTypePayload["label"] ?? "")) {
      height += 50;
    }

    if (isShowInputTotalPayment(_paymentMethod.value)) {
      height += 50;
    }

    return height.toDouble();
  }


  /// Change Payment Method.
  /// 
  /// The `changePaymentMethod` this function will handling do updating
  /// for variabel '_paymentMethod' which  will be to set in payload data.
  /// 
  /// Params:
  /// - `value` : a variabel value will set in `_paymentMethod` variabel.
  void changePaymentMethod(String value) {
    _paymentMethod.value = value;
  }


  /// Is Show Input Choose Customer.
  /// 
  /// The `_isShowInputChooseCustomer` this function will return `true`
  /// when data customer type not include in variabel `customerTypeWithoutName`
  /// and return `false` when value include in variabel.
  /// 
  /// Params: 
  /// - `value`: a variabel later will to chaeck if in variabel `customerTypeWithoutName` is not include.
  bool isShowInputChooseCustomer(String value) {
    if (value == "") return false;
    return !customerTypeWithoutName.contains(value.toLowerCase());
  }


  /// Is Show Input Total Payment.
  /// 
  /// The `isShowInputTotalPayment` is function will handling whather input total
  /// payment do showing in UI.
  /// 
  /// Params:
  /// - `value` : String value to be compared.
  bool isShowInputTotalPayment(String value) {
    if (value == "") return false;
    return paymentMethodOptions[1] == value;
  }
}