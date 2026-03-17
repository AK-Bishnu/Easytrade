import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/responsive_utils.dart';

class HomeHeroBanner extends StatefulWidget {
  const HomeHeroBanner({super.key});

  @override
  State<HomeHeroBanner> createState() => _HomeHeroBannerState();
}

class _HomeHeroBannerState extends State<HomeHeroBanner> {
  final List<_BannerItem> banners = [
    _BannerItem(
      title: "Buy & Sell with Confidence",
      subtitle: "Your trusted local marketplace",
      animation: "animations/splash.json",
    ),
    _BannerItem(
      title: "Find Amazing Deals",
      subtitle: "Discover great products near you",
      animation: "animations/a4.json",
    ),
    _BannerItem(
      title: "List Products in Seconds",
      subtitle: "Sell items quickly and easily",
      animation: "animations/ecommerce.json",
    ),
    _BannerItem(
      title: "Turn Items into Cash",
      subtitle: "Sell what you don't need anymore",
      animation: "animations/a3.json",
    ),
  ];

  int index = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 4),
          (_) {
        setState(() {
          index = (index + 1) % banners.length;
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    final bannerHeight = isMobile ? 140.0 : 180.0;
    final banner = banners[index];

    return Container(
      height: bannerHeight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.indigo.shade50,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Row(
            children: [

              /// TEXT AREA
              Expanded(
                flex: isMobile ? 5 : 4,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    key: ValueKey(banner.title),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        banner.title,
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade900,
                          height: 1.2,
                        ),
                        maxLines: 2,
                      ),

                      const SizedBox(height: 6),

                      Text(
                        banner.subtitle,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 30),

              /// ANIMATION AREA
              Expanded(
                flex: isMobile ? 5 : 6,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Lottie.asset(
                        banner.animation,
                        key: ValueKey(banner.animation),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerItem {
  final String title;
  final String subtitle;
  final String animation;

  _BannerItem({
    required this.title,
    required this.subtitle,
    required this.animation,
  });
}