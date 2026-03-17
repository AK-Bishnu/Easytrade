import 'package:flutter_riverpod/legacy.dart';

/// Sorting options
enum ProductSort {
  newest,
  oldest,
  priceLowToHigh,
  priceHighToLow,
}

/// State for selected sort
final productSortProvider = StateProvider<ProductSort>((ref) {
  return ProductSort.oldest;
});