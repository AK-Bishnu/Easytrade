import 'product_image_model.dart';

class Product {
  final int id;
  final int seller;
  final int category;

  final String title;
  final String description;
  final double price;
  final String location;

  final List<ProductImage> images;

  final DateTime createdAt;

  Product({
    required this.id,
    required this.seller,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.images,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      seller: json['seller'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      location: json['location'],

      images: (json['images'] as List)
          .map((img) => ProductImage.fromJson(img))
          .toList(),

      createdAt: DateTime.parse(json['created_at']),
    );
  }
}