import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_records/controllers/listing_controller.dart';
import 'package:stock_records/widgets/custom_search_delegates.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController _searchController = TextEditingController();
  ListingController listingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Stock List by Shyam'),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                ),
                /*IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    // controller.refreshStockRecords();
                  },
                ),*/
              ],
            );
          } else {
            // Tablet or desktop layout
            return Row(
              children: [
                const Text('Stock List by Shyam'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSubmitted: (query) {
                        // Handle search logic
                        listingController.onSearch(query);
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Jump Last Updated'),
                  onPressed: () {
                    //listingController.refreshStockRecords();
                    listingController.jumpLastUpdated();
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
