import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_records/controllers/listing_controller.dart';
import 'package:stock_records/models/sort_options.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  ListingController listingController = Get.find();
  SortOption? selectedSortOption;
  String? filterOption;

  final List<SortOption> sortOptions = [
    SortOption('Please Select', ''),
    SortOption('Sort by Name', 'name'),
    SortOption('Sort by target', 'target_price'),
    SortOption('Sort by Date', 'date'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSortOption = sortOptions.firstOrNull;
    filterOption = "Filter by Option 1";
  }

  void onSortChanged(SortOption? newSortType) {
    setState(() {
      selectedSortOption = newSortType;
      listingController.onSort(selectedSortOption);
      Navigator.of(context).pop(); // Close the drawer
      // stocks.clear();
    });
    // fetchData();
  }

  void clearFilter() {
    setState(() {
      listingController.onSort(null);
      selectedSortOption = sortOptions.firstOrNull;
      Navigator.of(context).pop(); // Close the drawer
      // filterOption = null;
      // stocks.clear();
    });
    // fetchData();
  }

  void onFilterApplied(String? newFilterOption) {
    setState(() {
      filterOption = newFilterOption;
      // stocks.clear();
    });
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text('Sort Options'),
            trailing: DropdownButton<SortOption>(
              value: selectedSortOption,
              icon: Icon(Icons.sort),
              onChanged: (SortOption? newValue) {
                onSortChanged(newValue);
              },
              items: sortOptions
                  .map<DropdownMenuItem<SortOption>>((SortOption option) {
                return DropdownMenuItem<SortOption>(
                  value: option,
                  child: Text(option.displayText),
                );
              }).toList(),
            ),
          ),
          Divider(),
          // Add more filter options here
          ListTile(
            title: Text('Filter Options'),
            trailing: DropdownButton<String>(
              value: filterOption,
              icon: Icon(Icons.filter_alt),
              onChanged: (String? newValue) {
                setState(() {
                  filterOption = newValue;
                });
              },
              items: <String>['Filter by Option 1', 'Filter by Option 2']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: clearFilter,
                  child: Text('Clear Filter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onFilterApplied(filterOption);
                    Navigator.of(context).pop();
                  },
                  child: Text('Apply Filter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
