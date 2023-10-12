import 'package:pos_application_mobile/data/data_source/remote_data_sources/remote_data_source.dart';
import 'package:pos_application_mobile/data/dtos/stock_dto.dart';
import 'package:pos_application_mobile/data/payloads/stock_adjustment_payload.dart';

class StockDataSource extends RemoteDataSource {

  /// Fetches Stock data from a remote API.
  /// 
  /// The `fetchData` function is responsible for retrieving Stock data from an API.
  /// It parse the JSON response and converts it into Dart data objects.
  /// 
  /// Parameters:
  /// - `queryParameters`: An optional map of query parameters to include in the request.
  ///
  /// Returns:
  /// A list of [StockDTO] objects representing the fetched user data.
  ///
  Future<List<StockDTO>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<StockDTO> response = await dioClient.getRequest(
      "api/stock-transactions",
      converter: (data) => List<StockDTO>.from(
        data["data"].map((d) => StockDTO.fromJson(d))
      ),
      queryParameters: queryParameters
    );
    return response;
  }


  /// Asynchronously adjusts the stock using the provided payload.
  ///
  /// This function sends a POST request to the "stock-adjustments" endpoint
  /// with the provided payload, and expects a JSON response containing stock
  /// data. It converts the response data to a [StockDTO] object using the
  /// provided converter function.
  ///
  /// Parameters:
  ///   - payload: The payload containing information for stock adjustment.
  ///
  /// Returns:
  ///   A [Future] that completes with a [StockDTO] object representing the
  ///   adjusted stock data once the HTTP request is successful.
  ///
  /// Example usage:
  /// ```dart
  /// final payload = StockAdjustmentPayload(/* provide payload data here */);
  /// final stockDTO = await stockAdjustment(payload);
  /// print(stockDTO); // Use the adjusted stock data as needed.
  /// ```
  Future<StockDTO> stockAdjustment(StockAdjustmentPayload payload) async {
    final StockDTO response = await dioClient.postRequest(
      "api/stock-adjustments", 
      converter: (data) => StockDTO.fromJson(data["data"]), 
      payload: payload.toJson()
    );

    return response;
  }
}