import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import 'responsive_wrapper.dart';

class PageContainer extends StatelessWidget {

  final Widget child;

  const PageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.lg,
        ),
        child: child,
      ),
    );
  }
}