import 'package:get/get_connect.dart';
import 'package:stock_records/network/request_interceptors.dart';
import 'package:stock_records/network/response_interceptors.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    //httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
    httpClient.timeout = const Duration(seconds: 20);
  }
}
