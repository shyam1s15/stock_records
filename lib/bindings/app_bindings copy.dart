import 'package:get/get.dart';
import 'package:stock_records/controllers/stock_controller.dart';
import 'package:stock_records/network/apiservice.dart';
import 'package:stock_records/network/base_provider.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(Apiservice(Get.find()), permanent: true);
    Get.put(StockController(), permanent: true);
  }
}
