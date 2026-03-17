import 'package:easytrade_web/features/categories/data/category_model.dart';
import 'package:easytrade_web/features/categories/data/category_repository.dart';
import 'package:easytrade_web/features/home/products/presentation/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final categoriesRepoProvider = Provider((ref) {
  return CategoryRepository(ref.read(apiClientProvider));
},);

final categoriesProvider = FutureProvider<List<Category>>((ref) {
  final repo = ref.read(categoriesRepoProvider);
  return repo.getCategories();
},);

final selectedCategoryProvider = StateProvider<int?>((ref) => null,);