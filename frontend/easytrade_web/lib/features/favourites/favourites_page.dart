import 'package:easytrade_web/core/widgets/product_card.dart';
import 'package:easytrade_web/features/home/products/presentation/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/auth_util.dart';
import '../home/products/data/product_model.dart';
import '../home/widgets/product_grid.dart';
import 'favourite_provider.dart';

class FavouritesPage extends ConsumerStatefulWidget {
  const FavouritesPage({super.key});

  @override
  ConsumerState<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends ConsumerState<FavouritesPage> {
  List<Product> favProducts = [];
  bool isLoading = true;
  String? error;

  Future<void> loadInitialFavourites() async {
    try {
      final notifier = ref.read(favouriteProvider.notifier);
      final products = await notifier.getFavourites();

      setState(() {
        favProducts = products;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
          await ensureLoggedIn(context);
        }
    );
    loadInitialFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final favIds = ref.watch(favouriteProvider);

    final visibleProducts =
    favProducts.where((p) => favIds.contains(p.id)).toList();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text("Error: $error"));
    }

    if (visibleProducts.isEmpty) {
      return const Center(child: Text("No favourite products yet ❤️"));
    }

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// PAGE HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Favourite Items",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Products you saved for later.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              /// PRODUCT CONTAINER
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade50,
                        Colors.indigo.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: ProductGrid(
                    itemCount: visibleProducts.length,
                    itemBuilder: (context, index) {
                      final product = visibleProducts[index];

                      return ProductCard(
                        isMyProduct: false,
                        product: product,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsPage(product: product),
                            ),
                          );

                          setState(() {});
                        },
                      );
                    },
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