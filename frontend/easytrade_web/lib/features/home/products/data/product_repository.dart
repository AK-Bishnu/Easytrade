import 'package:easytrade_web/features/profile/data/profile_model.dart';
import 'package:file_selector/file_selector.dart';
import '../../../../core/network/api_client.dart';
import 'product_model.dart';

class ProductRepository {
  final ApiClient api;

  ProductRepository(this.api);

  Future<List<Product>> getProducts({int? categoryId, String? sort}) async {
    String endpoint = "products/";

    final queryParams = <String, String>{};
    if (categoryId != null) queryParams['category'] = categoryId.toString();
    if (sort != null) queryParams['sort'] = sort; // pass sort query

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    final data = await api.get(uri.toString());

    return (data as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

  Future<List<Product>> myProducts() async {

    final res = await api.get("my-products/");

    return (res as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

  Future<Map<String, dynamic>> createProduct({
    required String title,
    required String description,
    required String price,
    required String location,
    required int categoryId,
    List<XFile> images = const [],
  }) async {
    // prepare fields
    final fields = {
      "title": title,
      "description": description,
      "price": price,
      "location": location,
      "category": categoryId.toString(),
    };

    final res = await api.multipartRequest("products/create/", fields, images);
    return res;
  }


  Future<Map<String,dynamic>> updateProduct(
      int id,
      Map<String,dynamic> data
      ) async {

    final res = await api.put(
      "products/update/$id/",
      data,
    );

    return res;
  }

  Future<Map<String,dynamic>> deleteProduct(int id) async {

    final res = await api.delete(
      "products/$id/delete/",
    );

    return res;
  }

  Future<UserProfile> getSeller(int id) async {
    final res = await api.get("users/$id/");

    return UserProfile.fromJson(res);
  }

}