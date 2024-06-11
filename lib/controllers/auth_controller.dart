import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_records/controllers/app_preference_service.dart';
import 'package:stock_records/routes.dart';

class AuthController extends GetxController {
  void signInWithGoogle() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null || AppPreferences.userToken == null) {
          print('User is currently signed out!');
        } else {
          Get.toNamed(Routes.RECORDS);
          return;
        }
      });

      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      //googleProvider
      //    .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
      // Once signed in, return the UserCredential
      UserCredential credential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      AppPreferences.userToken = await credential.user?.getIdToken();
      Get.toNamed(Routes.RECORDS);
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }
}
