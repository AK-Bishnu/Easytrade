import 'package:easytrade_web/core/network/api_client.dart';
import 'package:easytrade_web/features/categories/presentation/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../profile/data/profile_model.dart';
import '../../../sort/sort_provider.dart';
import '../data/product_model.dart';
import '../data/product_repository.dart';

final apiClientProvider = Provider((ref) => ApiClient(),);

final productRepoProvider = Provider((ref) {
  return ProductRepository(ref.read(apiClientProvider));
},);

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepoProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final sort = ref.watch(productSortProvider); // enum

  // Convert enum to backend string
  String sortQuery = 'oldest';
  switch (sort) {
    case ProductSort.newest:
      sortQuery = 'newest';
      break;
    case ProductSort.oldest:
      sortQuery = 'oldest';
      break;
    case ProductSort.priceLowToHigh:
      sortQuery = 'price_asc';
      break;
    case ProductSort.priceHighToLow:
      sortQuery = 'price_desc';
      break;
  }

  return repo.getProducts(categoryId: selectedCategory, sort: sortQuery);
});

final sellerProfileProvider = FutureProvider.family<UserProfile, int>((ref, sellerId) async {
  final repo = ref.read(productRepoProvider);
  final profile = await repo.getSeller(sellerId);
  return profile;
});
