import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool isPriceWithinTolerance(double? targetPrice, double? currentPrice) {
  if (targetPrice == null ||
      targetPrice == 0 ||
      currentPrice == null ||
      currentPrice == 0) {
    return false;
  }
  try {
    final absoluteDifference = currentPrice - targetPrice;
    final percentageDifference = (absoluteDifference / targetPrice) * 100;

    return percentageDifference.abs() <= 5;
  } on Exception catch (e) {
    print(e);
    return false;
  }
}

class Utility {
  static bool isMobile(BuildContext context) {
    // Check if the app is running on the web
    if (kIsWeb) {
      // Use MediaQuery to check screen width
      double screenWidth = MediaQuery.of(context).size.width;
      // Define breakpoint for "mobile-like" width
      return screenWidth < 600; // Example breakpoint for mobile width
    } else {
      // If not web, check if it's running on Android or iOS
      return Platform.isAndroid || Platform.isIOS;
    }
  }
}
