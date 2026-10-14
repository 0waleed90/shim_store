import 'package:my_store/feature/home/data/models/product_model/categories.dart';

class ProductModel {
  final String title;
  final String description;
  final Categories category;
  final int price;
  final int id;

  final List<String>? images;
  int quantity;

  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.id,
    required this.category,
    this.images,
    this.quantity = 1,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category.toJson(),
      'images': images,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      id: json['id'] ?? 0,
      category: Categories.fromJson(
        json['category'] != null
            ? Map<String, dynamic>.from(json['category'])
            : {},
      ),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      quantity: json['quantity'] ?? 1,
    );
  }
}
