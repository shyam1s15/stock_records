import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stock_records/models/stock_record.dart';
import 'package:stock_records/models/stock_record_list.dart';
import 'package:stock_records/network/apiservice.dart';
import 'package:stock_records/network/response_model.dart';

class ListingController extends GetxController with StateMixin {
  Apiservice apiservice = Get.find();
  var stockData = <StockRecord>[].obs;
  var page = 0;
  var isLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.loading());
    fetchStockRecords();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          fetchStockRecords();
        }
      }
    });
  }

  void fetchStockRecords() async {
    if (isLoading.value) {
      return;
    }

    isLoading.value = true;

    if (page == 0) {
      change(null, status: RxStatus.loading());
    }

    ResponseModel<StockRecordList?> apiResp =
        await apiservice.getStockRecordList(page);
    if (apiResp.errorInfo.error > 0) {
    } else {
      //print(apiResp.content?.records?.first.id?.oid);
      if (apiResp.content?.records != null) {
        stockData.addAll(apiResp.content!.records!);
      }
      if (page == 0) {
        change(apiResp.content?.records?.first.id?.oid,
            status: RxStatus.success());
      }
      page = page += 1;
    }
    isLoading.value = false;
  }

  void refreshStockRecords() async {
    isLoading.value = true;
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    change(null, status: RxStatus.loading());
    await apiservice.updateStockRecords();
    isLoading.value = false;
    page = 0;
    stockData.clear();
    fetchStockRecords();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
}
