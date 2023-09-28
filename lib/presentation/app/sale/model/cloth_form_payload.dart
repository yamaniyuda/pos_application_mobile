import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';


/// Cloth Form Payload
/// 
/// This class usage for data type in form add cloth. Usally used for handling
/// items choose add to bucked and place put data [ClothEntity].
/// 
/// Constructor:
/// - `items`: this params usage for place to store data [items] choose.
/// - `clothEntity`: This params usage for place to store data [clothEntity] from remote
///                 data source.
/// 
/// Items variable form:
/// ```dart
/// {
///   "[cloth_size_id]": {
///     "cloth_size_id": "9a00f5d5-f0e9-449c-b38f-38588dc4e23a",
///     "cloth_size_price_id": "9a00f5d5-f175-424e-9061-c39fa372cb20",
///     "name": "polo",
///     "price": 20000,
///     "qyt": 111,
///     "color": "red".
///     "size_name": "x"
///   },
///   "[cloth_size_id]": { ... }
/// }
/// ```
class ClothFormPayload {
  Map<String, Map<String, dynamic>> items = {};
  int totalItem;
  final ClothEntity clothEntity;

  static const clothSizeId = "cloth_size_id";
  static const clothSizePriceId = "cloth_size_price_id";
  static const qyt = "qyt";
  static const price = "price";
  static const name = "name";
  static const sizeName = "size_name";
  static const colorName = "color_name";

  ClothFormPayload({
    required this.items,
    required this.clothEntity,
    this.totalItem = 0
  });

  set setTotalItem(int total) {
    totalItem = total;
  }


  /// Retrieves the index of a cloth color within the cloth entity.
  ///
  /// This function searches for the index of a cloth color with a given identifier
  /// (`clothColorId`) within the list of cloth colors in the cloth entity. It is
  /// used to find the position of a specific cloth color within the list.
  ///
  /// Parameters:
  ///   - [clothColorId]: The identifier of the cloth color to search for.
  ///
  /// Returns:
  ///   - The index of the cloth color with the specified identifier if found, or
  ///     `null` if the cloth color is not found within the cloth entity.
  ///
  /// Example usage:
  /// ```dart
  /// int? colorIndex = _getClothColorIndexOf('color123');
  /// if (colorIndex != null) {
  ///   print('Found at index $colorIndex');
  /// } else {
  ///   print('Cloth color not found.');
  /// }
  /// ```
  int? _getClothColorIndexOf(String clothColorId) {
    for (var i = 0; i < clothEntity.clothColors!.length; i++) {
      if (clothEntity.clothColors![i].id == clothColorId) {
        return i;
      }
    }
    return null;
  }


  /// Retrieves the index of a cloth size within a specified cloth color.
  ///
  /// This function searches for the index of a cloth size with a given identifier
  /// (`clothSizeId`) within the cloth sizes of a specified cloth color. It is used
  /// to find the position of a specific cloth size within the list of sizes for a
  /// particular color.
  ///
  /// Parameters:
  ///   - [clothColorIndex]: The index of the cloth color within the cloth entity.
  ///   - [clothSizeId]: The identifier of the cloth size to search for.
  ///
  /// Returns:
  ///   - The index of the cloth size with the specified identifier if found, or
  ///     `null` if the cloth size is not found within the specified cloth color.
  ///
  /// Example usage:
  /// ```dart
  /// int? sizeIndex = _getClothSizeIndexOf(2, 'size123');
  /// if (sizeIndex != null) {
  ///   print('Found at index $sizeIndex');
  /// } else {
  ///   print('Cloth size not found.');
  /// }
  /// ```
  int? _getClothSizeIndexOf( int clothColorIndex , String clothSizeId) {
    for (var i = 0; i < clothEntity.clothColors![clothColorIndex].clothSizes!.length; i++) {
      if (clothEntity.clothColors![clothColorIndex].clothSizes![i].id == clothSizeId) {
        return i;
      }
    }

    return null;
  }


  int? _getClothSizeItemQuantity(String clothSizeId) {
    if (!items.containsKey(clothSizeId)) return null;
    return items[clothSizeId]![ClothFormPayload.qyt];
  }


  
  void updateItems({ required String clothColorId, required String clothSizeId, required String clothSizePriceId, required int qty, bool reset = false }) {
    try {
      /// Handling when update usage input field
      if (reset) resetItems(clothColorId: clothColorId, clothSizeId: clothSizeId, clothSizePriceId: clothSizePriceId);

      int? clothColorIndex = _getClothColorIndexOf(clothColorId);
      int? clothSizeIndex = _getClothSizeIndexOf(clothColorIndex!, clothSizeId);
      int currentStock = clothEntity.clothColors![clothColorIndex].clothSizes![clothSizeIndex!].stock!;
      int currentStockChoose = _getClothSizeItemQuantity(clothSizeId) ?? 0;
      if (qty > 0 && currentStock != 0) {
        
        /// Increment Items Handling.
        if (qty > currentStock ) { qty = currentStock; }

        if (!items.containsKey(clothSizeId)) {
          final Map<String, dynamic> mapTemplateItem = { clothSizeId: "", clothSizePriceId: "", name: "", sizeName: "", colorName: "", qyt: 0, price: 0 };

          items[clothSizeId] = mapTemplateItem;
          
          final Map<String, dynamic> detailItem = { 
            ClothFormPayload.clothSizeId: clothSizeId,
            ClothFormPayload.clothSizePriceId: clothSizePriceId,
            ClothFormPayload.name: clothEntity.clothCategory!.name,
            ClothFormPayload.qyt: currentStockChoose + qty,
            ClothFormPayload.colorName: clothEntity.clothColors![clothColorIndex].color!.name,
            ClothFormPayload.sizeName: clothEntity.clothColors![clothColorIndex].clothSizes![clothSizeIndex].size!.name,
            ClothFormPayload.price: clothEntity.clothColors![clothColorIndex].clothSizes![clothSizeIndex].price!.price!
          };

          items[clothSizeId] = detailItem;
        } else {
          items[clothSizeId]![ClothFormPayload.qyt] = currentStockChoose + qty;
        }
        
      } else {
        /// Decrement Items Handling.
        if (items.containsKey(clothColorId)) return;
        if (qty <= -2 || qyt == 0) { qty = -currentStock; }
        items[clothSizeId]![ClothFormPayload.qyt] = currentStockChoose + qty;
        if (currentStockChoose + qty == 0) items.remove(clothSizeId);
      }

      clothEntity.clothColors![clothColorIndex].clothSizes![clothSizeIndex].setStock = currentStock - qty;

      calculateTotalItem();
    } catch (e) {
      return;
    }
  }


  void resetItems({ required String clothColorId, required String clothSizeId, required String clothSizePriceId }) {
    if (items[clothSizeId] == null) return;

    final currentItemQuantity = int.parse(items[clothSizeId]![ClothFormPayload.qyt].toString());
    int clothColorIndex = _getClothColorIndexOf(clothColorId)!;
    int clothSizeIndex = _getClothSizeIndexOf(clothColorIndex, clothSizeId)!;
    int currentStock = clothEntity.clothColors![clothColorIndex].clothSizes![clothSizeIndex].stock!;
    items.remove(clothSizeId);
    clothEntity.clothColors![clothColorIndex].clothSizes![clothSizeIndex].setStock = currentStock + currentItemQuantity;
    calculateTotalItem();
  }


  /// Calculates the total quantity of items for a cloth entity.
  ///
  /// This function iterates through the items associated with different cloth sizes
  /// and calculates the total quantity. It assumes that the items are represented
  /// as a map where the keys are cloth size identifiers, and the values are maps
  /// containing a "qyt" key representing the quantity.
  ///
  /// Returns:
  ///   - The total quantity of items as an integer.
  ///
  /// Example usage:
  /// ```dart
  /// int totalItems = calculateTotalItem();
  /// print('Total items: $totalItems');
  /// ```
  int calculateTotalItem() {
    int total = 0;

    for (var clothSizeId in items.entries) {
      total += clothSizeId.value["qyt"] as int;
    }

    setTotalItem = total;
    return total;
  }
}