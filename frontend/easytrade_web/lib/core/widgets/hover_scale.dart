import 'package:flutter/material.dart';

class HoverScale extends StatefulWidget {

  final Widget child;

  const HoverScale({super.key, required this.child});

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {

  bool hovering = false;

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: hovering ? 1.03 : 1,
        child: widget.child,
      ),
    );
  }
}