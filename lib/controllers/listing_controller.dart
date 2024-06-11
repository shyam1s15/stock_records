import 'package:get/get.dart';
import 'package:stock_records/models/stock_record_list.dart';
import 'package:stock_records/network/apiservice.dart';
import 'package:stock_records/network/response_model.dart';

class ListingController extends GetxController with StateMixin {
  Apiservice apiservice = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.loading());
    fetchStockRecords();
  }

  void fetchStockRecords() async {
    change(null, status: RxStatus.loading());
    ResponseModel<StockRecordList?> apiResp =
        await apiservice.getStockRecordList();
    if (apiResp.errorInfo.error > 0) {
    } else {
      print(apiResp.content?.records?.first.id?.oid);
      change(apiResp.content?.records?.first.id?.oid, status: RxStatus.success());
    }
  }
}
