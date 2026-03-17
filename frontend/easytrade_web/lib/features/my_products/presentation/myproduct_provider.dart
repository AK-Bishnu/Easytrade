import 'package:easytrade_web/features/home/products/data/product_model.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../home/products/data/product_repository.dart';
import '../../home/products/presentation/product_provider.dart';

final productRepoProvider = Provider((ref) {
  return ProductRepository(ref.read(apiClientProvider));
});

final myProductsProvider = StateNotifierProvider<ProductController, bool>((ref) {

  return ProductController(
    ref.read(productRepoProvider),
  );

});


class ProductController extends StateNotifier<bool> {

  final ProductRepository repo;

  ProductController(this.repo) : super(false);


  Future<List<Product>> myProducts() async {

    final res = await repo.myProducts();

    return res;
  }

  Future<bool> createProduct({
    required String title,
    required String description,
    required String price,
    required String location,
    required int categoryId,
    List<XFile> images = const [],
  }) async {
    state = true; // loading
    try {
      final res = await repo.createProduct(
        title: title,
        description: description,
        price: price,
        location: location,
        categoryId: categoryId,
        images: images,
      );
      return res['success'];
    } finally {
      state = false;
    }
  }

  Future<void> deleteProduct(int id) async {

    await repo.deleteProduct(id);

  }


  Future<void> updateProduct(
      int id,
      Map<String,dynamic> data
      ) async {

    await repo.updateProduct(id, data);

  }

}
