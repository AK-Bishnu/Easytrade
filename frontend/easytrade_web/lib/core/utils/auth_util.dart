import 'package:easytrade_web/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../storage/token_storage.dart';

Future<void> ensureLoggedIn(BuildContext context) async {
  final access = await TokenStorage.getToken();
  final refresh = await TokenStorage.getRefreshToken();

  // If any token exists → session might still be valid
  if (access != null || refresh != null) return;

  // No tokens → logout
  if (context.mounted) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        title: Text("Session Expired"),
        content: Text(
          "Your session has expired. Redirecting to login...",
          textAlign: TextAlign.center,
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }
  }
}