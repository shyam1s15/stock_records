import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_records/controllers/auth_controller.dart';

class WelcomePage extends GetView<AuthController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Welcome to Ayush Record System')),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/sheraa-95d17.appspot.com/o/ayush%20image.png?alt=media',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(), // Placeholder widget while loading
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 250,
                    width: 250,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    controller.signInWithGoogle();
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Sign in with Google'),
                )
              ],
            ),
          ),
        ));
  }
}
  