import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:stock_records/controllers/listing_controller.dart';
import 'package:stock_records/routes.dart';
import 'package:stock_records/widgets/stock_list_tile.dart';

// class StockListingPage extends StatefulWidget {
//   const StockListingPage({super.key});

//   @override
//   State<StockListingPage> createState() => _StockListingPageState();
// }

// class _StockListingPageState extends State<StockListingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return ConcentricAnimationOnboarding();
//   }
// }

class StockListingPage extends GetView<ListingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Stock List made by Shyam'),
          trailing: ElevatedButton(
            child: Text('Refresh'),
            onPressed: () {
              controller.refreshStockRecords();
            },
          ),
        ),
      ),
      body: controller.obx(
        (state) {
          if (state == null) {
            return _isLoading();
          }
          return Obx(() {
            return ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.stockData.length +
                  (controller.isLoading.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.stockData.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StockRecordTile(
                  stockRecord: controller.stockData[index],
                );
              },
            );
          });
        },
        onLoading: _isLoading(),
        onEmpty: _emptyListWidget(),
        onError: (error) {
          print(error);
          return _emptyListWidget();
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget _isLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _emptyListWidget() {
    return Scaffold(
      appBar: AppBar(title: Text('Some Text')),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
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
                  CircularProgressIndicator(), // Placeholder widget while loading
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 250,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}

final pages = [
  const PageData(
    icon: Icons.food_bank_outlined,
    title: "Search for your favourite food",
    bgColor: Color(0xff3b1791),
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.shopping_bag_outlined,
    title: "Add it to cart",
    bgColor: Color(0xfffab800),
    textColor: Color(0xff3b1790),
  ),
  const PageData(
    icon: Icons.delivery_dining,
    title: "Order and wait",
    bgColor: Color(0xffffffff),
    textColor: Color(0xff3b1790),
  ),
];

class ConcentricAnimationOnboarding extends StatefulWidget {
  ConcentricAnimationOnboarding({Key? key}) : super(key: key);

  @override
  State<ConcentricAnimationOnboarding> createState() =>
      _ConcentricAnimationOnboardingState();
}

class _ConcentricAnimationOnboardingState
    extends State<ConcentricAnimationOnboarding> {
  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    final screenWidth = 50;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.45,
        // pageSnapping: true,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 1), // visual center
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.5,
            color: Colors.white,
          ),
        ),
        // enable itemcount to disable infinite scroll
        itemCount: pages.length,
        // opacityFactor: 2.0,
        scaleFactor: 2,
        // verticalPosition: 0.7,
        // direction: Axis.vertical,
        // itemCount: pages.length,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight = 400;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: page.textColor),
          child: Icon(
            page.icon,
            size: screenHeight * 0.1,
            color: page.bgColor,
          ),
        ),
        Text(
          page.title ?? "",
          style: TextStyle(
              color: page.textColor,
              fontSize: screenHeight * 0.035,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
