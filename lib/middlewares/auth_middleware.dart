import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:stock_records/controllers/app_preference_service.dart';
import 'package:stock_records/routes.dart';

class AuthMiddleware extends GetMiddleware {
  // priority this value the smaller the better
  @override
  int? priority = 0;

  AuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    // bool isUserSignedIn = true;
     // Await for the first authentication state change
    
    // ***************** UNCOMMENT IT BEFORE DEPLOYING
    /*User? user = FirebaseAuth.instance.currentUser;
    if (user == null || AppPreferences.userToken == null && ((route ?? "") != Routes.WELCOME_SCREEN)) {
      print('User is currently signed out or user token is missing!');
      return const RouteSettings(name: Routes.WELCOME_SCREEN);
    }
    
    print("token :::${AppPreferences.userToken ?? ""}");
    return null;*/
    // ***************************
    
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null || AppPreferences.userToken == null) {
    //     print('User is currently signed out!');
    //     isUserSignedIn = false;
    //   }
    // });
    // if (!isUserSignedIn) {
    //   print("token :::" + (AppPreferences.userToken ?? ""));
    //   return const RouteSettings(name: Routes.WELCOME_SCREEN);
    // }
    // print("token :::" + (AppPreferences.userToken ?? ""));
    // return null;
  }
}
