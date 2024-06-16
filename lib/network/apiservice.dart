import 'package:stock_records/controllers/app_preference_service.dart';
import 'package:stock_records/models/stock_record_list.dart';
import 'package:stock_records/network/base_provider.dart';
import 'package:stock_records/network/response_model.dart';
import 'package:stock_records/network/typedef.dart';

class Apiservice {
  final BaseProvider _baseProvider;

  Apiservice(this._baseProvider);

  Future<ResponseModel<StockRecordList?>> getStockRecordList(int page) async {
    return post(StockRecordList.fromJson,
        endpoint:
            "https://asia-south1-sheraa-95d17.cloudfunctions.net/stock-records-listing",
        body: {'page': page});
  }

  Future<ResponseModel<void>> updateStockRecords() async {
    return post(null,
        endpoint:
            "https://asia-south1-sheraa-95d17.cloudfunctions.net/stock-records",
        body: {});
  }

  Future<ResponseModel<T?>> post<T>(
      T Function(Map<String, dynamic> json)? fromJson,
      {required String endpoint,
      JSON? body,
      JSON? query,
      Map<String, String>? headers,
      bool requiresAuthToken = false,
      bool printLog = false}) async {
    var customHeaders = {
      'Accept': 'application/json',
      if (requiresAuthToken) 'Authorization': '',
      'user-token': AppPreferences.userToken ?? ''
    };

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    try {
      final response = await _baseProvider.post(endpoint, body,
          headers: customHeaders, query: query);
      ResponseModel<T?> apiResp =
          ResponseModel.fromJson(response.body, fromJson);

      // dynamic responseBody = json.decode(response.body);
      if (printLog) {
        print(response.bodyString);
      }
      return apiResp;
    } on Exception catch (e) {
      print("exception ::: $e");
      return ResponseModel(
          content: null, errorInfo: ErrorInfo(error: 1, message: "$e"));
    }
  }

  Future<void> saveTargetPriceAndNote(String? id, double? target, String note) {
    return post(null,
        endpoint:
            "https://asia-south1-sheraa-95d17.cloudfunctions.net/stock_record_target_function",
        body: {"id": id, "target_price": target, "note": note});
  }
}
