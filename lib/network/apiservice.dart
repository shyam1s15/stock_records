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

  Future<ResponseModel<T?>> post<T>(
    T Function(Map<String, dynamic> json) fromJson, {
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
      if (requiresAuthToken) 'Authorization': '',
      'user-token': AppPreferences.userToken ?? ''
    };

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.post(endpoint, body,
        headers: customHeaders, query: query);
    //dynamic responseBody = json.decode(response.body);

    // return response.body;
    // print(response.bodyString);
    ResponseModel<T?> apiResp = ResponseModel.fromJson(response.body, fromJson);
    return apiResp;
  }
}
