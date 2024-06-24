import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_records/controllers/listing_controller.dart';
import 'package:stock_records/widgets/stock_list_tile.dart';

class CustomSearchDelegate extends SearchDelegate {
  ListingController listingController = Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          listingController.clearSearch();
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        listingController.clearSearch();
        close(context, null);
        print("cleared...");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listingController.onSearch(query);
    });
    return Obx(() {
      if (listingController.isLoading.value) {
        return _isLoading();
      } else if (listingController.stockData.isEmpty) {
        return _emptyListWidget();
      } else {
        return ListView.builder(
          controller: listingController.scrollController,
          itemCount: listingController.stockData.length,
          itemBuilder: (context, index) {
            if (index == listingController.stockData.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StockRecordTile(
              stockRecord: listingController.stockData[index],
            );
          },
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Search suggestions here'));
  }

  Widget _isLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _emptyListWidget() {
    return SafeArea(
      child: ListView(
        children: [
          const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // CustomButton(
              //   text: 'Add OPD',
              //   color: Colors.green,
              //   onPressed: () {
              //     Get.toNamed(Routes.WELCOME_SCREEN, arguments: {'new_opd': true});
              //   },
              // )
            ],
          ),
          CachedNetworkImage(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/sheraa-95d17.appspot.com/o/no-data-image.jpg?alt=media',
            placeholder: (context, url) =>
                const CircularProgressIndicator(), // Placeholder widget while loading
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 250,
            width: 250,
          ),
        ],
      ),
    );
  }
}
