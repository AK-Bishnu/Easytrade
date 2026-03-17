

import '../../../core/network/api_client.dart';
import 'category_model.dart';

class CategoryRepository {

  final ApiClient api;

  CategoryRepository(this.api);

  Future<List<Category>> getCategories() async {
    final data = await api.get("categories/");

    return (data as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }
}