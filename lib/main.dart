import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:stock_records/bindings/app_bindings%20copy.dart';
import 'package:stock_records/constants/themes.dart';
import 'package:stock_records/controllers/app_preference_service.dart';
import 'package:stock_records/controllers/theme_controller.dart';
import 'package:stock_records/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async {
  AppPreferences.init();
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {
  final ThemesController themeController = Get.put(ThemesController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Medical records app',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: getThemeMode(themeController.theme),
      getPages: Routes.routes,
      // initialRoute: Routes.WELCOME_SCREEN,
      initialRoute: Routes.WELCOME_SCREEN,
      initialBinding: AppBinding(),
      defaultTransition: Transition.fade,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultTransitionDuration,
    );
  }

  ThemeMode getThemeMode(String type) {
    ThemeMode themeMode = ThemeMode.system;
    switch (type) {
      case "system":
        themeMode = ThemeMode.system;
        break;
      case "dark":
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }

    return themeMode;
  }
}
