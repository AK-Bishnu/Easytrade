import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1200) {
      return Center(
        child: SizedBox(width: 1100, child: child),
      );
    }

    if (width > 800) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: child,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );

  }
}