import 'package:get/get.dart';
import 'package:stock_records/bindings/auth_bindings.dart';
import 'package:stock_records/bindings/listing_page_bindings.dart';
import 'package:stock_records/middlewares/auth_middleware.dart';
import 'package:stock_records/screens/stock_listing_page.dart';
import 'package:stock_records/screens/welcome_page.dart';

class Routes {
  // static const INITIAL = '/home';
  static const NOT_FOUND = '/not-found';
  static const RECORDS = '/records';
  static const WELCOME_SCREEN = '/welcome';

  static final routes = [
    //   GetPage(
    //     name: '/splash',
    //     page: () => SplashPage(),
    //   ),
    //   GetPage(
    //     name: '/login',
    //     page: () => LoginPage(),
    //   ),
    // GetPage(
    //     name: '/home',
    //     page: () => StockListingPage(),
    //     binding: HomeBinding(),
    //     //middlewares: [
    //     //  PlatformMiddleware(priority: 0),
    //     //]
    //     ),
    // GetPage(
    //   name: NOT_FOUND,
    //   page: () => NotFoundPage(),
    // ),
    GetPage(
        name: RECORDS,
        page: () => const StockListingPage(),
        binding: ListingPageBindings(),
        middlewares: [AuthMiddleware(priority: 0)]
        ),
    GetPage(name: WELCOME_SCREEN, page: () => const WelcomePage(), binding: AuthBinding(),
    // middlewares: [AuthMiddleware(priority: 0)]
    )
  ];
}