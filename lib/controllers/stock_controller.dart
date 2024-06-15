import 'package:get/get.dart';
import 'package:stock_records/models/stock_record.dart';
import 'package:stock_records/network/apiservice.dart';

class StockController extends GetxController {
  Apiservice apiservice = Get.find();

  void saveTargetPriceAndNote(String? id, String target, String note) async {
    await apiservice.saveTargetPriceAndNote(id, target, note);
  }
}