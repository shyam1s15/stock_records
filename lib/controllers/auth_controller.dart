import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stock_records/controllers/app_preference_service.dart';
import 'package:stock_records/routes.dart';

class AuthController extends GetxController {
  // void signInWithGoogle() async {
  //   try {
  //     FirebaseAuth.instance.authStateChanges().listen((User? user) async {
  //       if (user == null || AppPreferences.userToken == null) {
  //         print('User is currently signed out!');
  //       } else {
  //         AppPreferences.userToken = await user.getIdToken();
  //         Get.toNamed(Routes.RECORDS);
  //         return;
  //       }
  //     });

  //     // Create a new provider
  //     GoogleAuthProvider googleProvider = GoogleAuthProvider();
  //     //googleProvider
  //     //    .addScope('https://www.googleapis.com/auth/contacts.readonly');
  //     googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
  //     // Once signed in, return the UserCredential
  //     UserCredential credential =
  //         await FirebaseAuth.instance.signInWithPopup(googleProvider);
  //     AppPreferences.userToken = await credential.user?.getIdToken();
  //     print("token after auth :::${AppPreferences.userToken ?? ""}");
  //     Get.toNamed(Routes.RECORDS);
  //   } catch (error) {
  //     print('Error signing in with Google: $error');
  //     return null;
  //   }
  // }

  void signInWithGoogle() async {
  try {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Sign in with Google
    UserCredential credential = await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Update the token
    AppPreferences.userToken = await credential.user?.getIdToken();
    print("token after auth :::${AppPreferences.userToken ?? ""}");

    // Navigate to the RECORDS route
    Get.toNamed(Routes.RECORDS);
  } catch (error) {
    print('Error signing in with Google: $error');
  }
}

}
