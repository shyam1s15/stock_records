import 'package:get/get.dart';
import 'package:stock_records/network/apiservice.dart';

class StockController extends GetxController {
  Apiservice apiservice = Get.find();

  void saveTargetPriceAndNote(String? id, double? target, String note, int? lastPageId) async {
    await apiservice.saveTargetPriceAndNote(id, target, note, lastPageId);
  }
}
