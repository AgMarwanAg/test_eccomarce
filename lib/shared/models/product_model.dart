import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/core/utls/parse_utls.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final String thumbnail;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.thumbnail,
    required this.images
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: ParseUtils.asInt(json['id']),
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    category: json['category'] ?? '',
    price: ParseUtils.asDouble(json['price']),
    discountPercentage:
        ParseUtils.asDouble(json['discountPercentage']),
    rating: ParseUtils.asDouble(json['rating']),
    stock: ParseUtils.asInt(json['stock']),
    tags: ParseUtils.asList<String>(json['tags']),
    brand: json['brand'] ?? '',
    sku: json['sku'] ?? '',
    weight: ParseUtils.asInt(json['weight']),
    thumbnail: json['thumbnail'],
    images: List.from(json['images'])
  );
}

  static List<ProductModel> fromList(List<dynamic> list) {
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ---------- Dummy List ----------
  static List<ProductModel> fromDummyList([int length = 10]) {
    return List.generate(
      length,
      (index) => ProductModel(
        id: index,
        title: 'title',
        description: 'description',
        category: 'category',
        price: 1,
        discountPercentage: 1,
        rating: 1,
        stock: 1,
        tags: ['tag 1', 'tag 2', 'tag 3'],
        brand: 'brand',
        sku: 'sku',
        weight: 100,
        images: [],
        thumbnail: ''
      ),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    tags,
    brand,
    sku,
    weight,
  ];
}
