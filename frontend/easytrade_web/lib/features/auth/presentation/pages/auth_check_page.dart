import 'package:easytrade_web/core/layout/app_layout.dart';
import 'package:easytrade_web/core/storage/token_storage.dart';
import 'package:easytrade_web/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {

    final token = await TokenStorage.getToken();

    if (!mounted) return;

    if (token == null) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );

    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AppLayout(),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}