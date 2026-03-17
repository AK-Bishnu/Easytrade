import 'package:flutter_riverpod/legacy.dart';
import '../../../core/network/api_client.dart';
import '../home/products/data/product_model.dart';



final favouriteProvider =
StateNotifierProvider<FavouriteNotifier, Set<int>>((ref) {
  final notifier =  FavouriteNotifier();
  notifier.loadFavourites();
  return notifier;
});


class FavouriteNotifier extends StateNotifier<Set<int>> {
  FavouriteNotifier() : super({});

  final api = ApiClient();

  Future<void> loadFavourites() async {
    final products = await getFavourites();
    state = products.map((p) => p.id).toSet();
  }

  Future<void> toggleFavourite(int productId) async {
    final res = await api.post(
      "products/$productId/favourite/",
      {},
    );

    final isFav = res["favourited"];

    if (isFav) {
      state = {...state, productId};
    } else {
      final newState = {...state};
      newState.remove(productId);
      state = newState;
    }
  }

  bool isFavourite(int productId) {
    return state.contains(productId);
  }

  Future<List<Product>> getFavourites() async {
    final response = await api.get("favourites/");

    return (response as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

}