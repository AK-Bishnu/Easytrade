import 'package:easytrade_web/features/home/products/presentation/product_details_page.dart';
import 'package:easytrade_web/features/post/presentation/post_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/auth_util.dart';
import '../../home/products/data/product_model.dart';
import '../../../../core/widgets/product_card.dart';
import '../../home/widgets/product_grid.dart';
import 'edit_product_page.dart';
import 'myproduct_provider.dart';

class MyProductsPage extends ConsumerStatefulWidget {
  const MyProductsPage({super.key});

  @override
  ConsumerState<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends ConsumerState<MyProductsPage> {
  List<Product> products = [];
  bool loading = true;
  String? error;

  Future<void> loadProducts() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final controller = ref.read(myProductsProvider.notifier);
      final res = await controller.myProducts();

      setState(() {
        products = res;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() => loading = false);
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
    loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => _buildDeleteDialog(),
    );

    if (confirm != true) return;

    try {
      await ref.read(myProductsProvider.notifier).deleteProduct(id);
      await loadProducts();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Product deleted successfully"),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Delete failed: $e"),
          backgroundColor: Colors.red.shade600,
        ),
      );
    }
  }

  Widget _buildDeleteDialog() {
    return AlertDialog(
      title: const Text("Delete Product"),
      content: const Text(
          "Are you sure you want to delete this product? This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Delete"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text("Error: $error"));
    }

    if (products.isEmpty) {
      return const Center(child: Text("No products yet."));
    }

    return Scaffold(

      body: RefreshIndicator(
        onRefresh: loadProducts,
        child: Center(
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
                        "My Products",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Manage, post, and track the products you have listed.",
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
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final p = products[index];

                        return ProductCard(
                          product: p,
                          isMyProduct: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailsPage(product: p),
                              ),
                            );
                          },
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProductPage(product: p),
                              ),
                            ).then((_) => loadProducts());
                          },
                          onDelete: () {
                            deleteProduct(p.id);
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
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PostProductPage(),
            ),
          ).then((_) => loadProducts());
        },
        icon: const Icon(Icons.add),
        label: const Text(
          "Post Product",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}