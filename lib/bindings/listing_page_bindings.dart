
import 'package:get/get.dart';
import 'package:stock_records/controllers/listing_controller.dart';

class ListingPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingController>(() => ListingController());
  }
}

