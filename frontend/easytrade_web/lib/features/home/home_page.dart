import 'package:easytrade_web/features/home/products/presentation/product_list_page.dart';
import 'package:easytrade_web/features/home/widgets/category_filter.dart';
import 'package:easytrade_web/features/home/widgets/home_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/auth_util.dart';
import '../sort/sort_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
          await ensureLoggedIn(context);
        }
    );

    return Container(
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HERO BANNER
          const HomeHeroBanner(),
          const SizedBox(height: 16),

          /// CATEGORY HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.category_outlined,
                        size: 16,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Browse Categories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Swipe →",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// CATEGORY FILTER
          const CategoryFilter(),


          /// PRODUCT HEADER + SORT DROPDOWN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left: Title
                Row(
                  children: const [
                    Icon(Icons.grid_view_outlined, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Available Products",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Consumer(
                  builder: (context, ref, child) {
                    final sort = ref.watch(productSortProvider);

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sort,
                          size: 20,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sort:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<ProductSort>(
                          value: sort,
                          onChanged: (value) {
                            if (value != null) {
                              ref.read(productSortProvider.notifier).state = value;
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: ProductSort.newest,
                              child: Text("Newest"),
                            ),
                            DropdownMenuItem(
                              value: ProductSort.oldest,
                              child: Text("Oldest"),
                            ),
                            DropdownMenuItem(
                              value: ProductSort.priceLowToHigh,
                              child: Text("Price: Low → High"),
                            ),
                            DropdownMenuItem(
                              value: ProductSort.priceHighToLow,
                              child: Text("Price: High → Low"),
                            ),
                          ],
                          underline: Container(), // Removes the default underline
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade700,
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 2,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),



          /// PRODUCT LIST
          const Expanded(
            child: ProductListPage(),
          ),
        ],
      ),
    );
  }
}