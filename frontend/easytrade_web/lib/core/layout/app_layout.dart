import 'package:easytrade_web/features/favourites/favourites_page.dart';
import 'package:easytrade_web/features/home/home_page.dart';
import 'package:easytrade_web/features/my_products/presentation/my_products_page.dart';
import 'package:easytrade_web/features/profile/presentation/profile_page.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const FavouritesPage(),
    const MyProductsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 650;
    final isTablet = width >= 650 && width < 1100;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade700,
        centerTitle: false,

        title: isTablet
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.storefront_outlined,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'EasyTrade',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ],
            ),
            const Text(
              ' - a mini marketplace',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            )
          ],
        )
            : Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.storefront_outlined,
                color: Colors.blue.shade700,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'EasyTrade',
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(width: 6),
            const Text(
              '- a mini marketplace',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),

        /// ACTIONS
        actions: isMobile
            ? [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ]
            : _buildNavigationActions(),

        /// subtle bottom border
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),

      /// BODY
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 0 : (isTablet ? 16 : 24),
        ),
        child: pages[currentIndex],
      ),

      /// RIGHT SIDE DRAWER
      endDrawer: isMobile ? _buildDrawer(context) : null,
    );
  }

  /// DRAWER
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          /// HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade500,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// ROUND LOGO
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: .2),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/easyTrade.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "EasyTrade",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "Your mini marketplace",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// NAV ITEMS
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _buildDrawerItem(Icons.home_outlined, Icons.home, "Home", 0),
                _buildDrawerItem(
                    Icons.favorite_outline, Icons.favorite, "Favourites", 1),
                _buildDrawerItem(Icons.inventory_2_outlined,
                    Icons.inventory_2, "My Products", 2),
                _buildDrawerItem(
                    Icons.person_outline, Icons.person, "Profile", 3),

                const SizedBox(height: 10),
                const Divider(),

                _buildDrawerItem(Icons.logout, Icons.logout, "Logout", -1,
                    isLogout: true),
              ],
            ),
          ),

          /// FOOTER
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// DESKTOP NAVIGATION
  List<Widget> _buildNavigationActions() {
    return [
      _buildNavItem("Home", 0),
      _buildNavItem("Favourites", 1),
      _buildNavItem("My Products", 2),
      _buildNavItem("Profile", 3),
      const SizedBox(width: 8),
    ];
  }

  /// DESKTOP NAV BUTTON
  Widget _buildNavItem(String label, int index) {
    final isSelected = currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () {
          setState(() {
            currentIndex = index;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor:
          isSelected ? Colors.blue.shade50 : Colors.transparent,
          foregroundColor:
          isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// DRAWER ITEM
  Widget _buildDrawerItem(
      IconData icon,
      IconData selectedIcon,
      String label,
      int index, {
        bool isLogout = false,
      }) {
    final isSelected = currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blue.shade50
            : (isLogout ? Colors.red.shade50 : Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          isSelected ? selectedIcon : icon,
          color: isSelected
              ? Colors.blue.shade700
              : (isLogout ? Colors.red.shade600 : Colors.grey.shade700),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? Colors.blue.shade700
                : (isLogout ? Colors.red.shade700 : Colors.black87),
          ),
        ),
        trailing: isSelected
            ? Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            shape: BoxShape.circle,
          ),
        )
            : null,
        onTap: () {
          if (isLogout) {
            _showLogoutDialog(context);
          } else {
            setState(() {
              currentIndex = index;
            });
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  /// LOGOUT DIALOG
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}