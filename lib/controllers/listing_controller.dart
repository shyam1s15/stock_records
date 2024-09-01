import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stock_records/models/sort_options.dart';
import 'package:stock_records/models/stock_record.dart';
import 'package:stock_records/models/stock_record_list.dart';
import 'package:stock_records/models/stock_settings_model.dart';
import 'package:stock_records/network/apiservice.dart';
import 'package:stock_records/network/response_model.dart';

class ListingController extends GetxController with StateMixin {
  Apiservice apiservice = Get.find();
  String? selectedSortOption = "";
  String? search = null;
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
    // scrollController.addListener(() {
    //   if (scrollController.position.atEdge) {
    //     if (scrollController.position.pixels != 0) {
    //       fetchStockRecords();
    //     }
    //   }
    // });
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
        await apiservice.getStockRecordList(page, selectedSortOption, search);
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
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    change(null, status: RxStatus.loading());
    apiservice.updateStockRecords();
    isLoading.value = false;
    page = 0;
    stockData.clear();
    fetchStockRecords();
  }

  void jumpLastUpdated() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    ResponseModel<StockRecordModel?> resp = await apiservice.getLastPage();
    if (resp.content?.settings != null) {
      int? pageId = resp.content!.settings!.lastPageId;
      print(pageId);
      if (pageId != null && pageId > 0 && pageId > page) {
        ResponseModel<StockRecordList?> apiResp = await apiservice
            .getStockRecordList(pageId, selectedSortOption, search);

        stockData.clear();
        if (apiResp.errorInfo.error > 0) {
        } else {
          //print(apiResp.content?.records?.first.id?.oid);
          if (apiResp.content?.records != null) {
            stockData.addAll(apiResp.content!.records!);
          }
        }
      }
    }

    isLoading.value = false;
    change(page, status: RxStatus.success());
  }

  void jumpToNewPage(int index) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());

    ResponseModel<StockRecordList?> apiResp =
        await apiservice.getStockRecordList(index, selectedSortOption, search);

    stockData.clear();
    page = index+1;
    if (apiResp.errorInfo.error > 0) {
    } else {
      //print(apiResp.content?.records?.first.id?.oid);
      if (apiResp.content?.records != null) {
        stockData.addAll(apiResp.content!.records!);
      }
    }

    isLoading.value = false;
    change(page, status: RxStatus.success());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

  void onSearch(String? search) {
    this.search = search;
    change(null, status: RxStatus.loading());
    isLoading.value = false;
    page = 0;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    stockData.clear();
    fetchStockRecords();
  }

  void clearSearch() {
    this.search = null;
    change(null, status: RxStatus.loading());
    isLoading.value = false;
    page = 0;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    stockData.clear();
    fetchStockRecords();
  }

  void onSort(SortOption? sort) {
    selectedSortOption = sort?.backendValue;
    stockData.clear();
    page = 0;
    isLoading.value = false;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    fetchStockRecords();
  }
}
