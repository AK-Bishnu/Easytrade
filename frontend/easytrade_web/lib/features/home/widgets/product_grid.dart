import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  static const double cardWidth = 260.0;
  static const double cardAspectRatio = 0.70;
  static const double cardHeight = cardWidth / cardAspectRatio;

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const ProductGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: false,
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: cardWidth,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: cardAspectRatio,
      ),
      itemBuilder: (context, index) {
        return SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}