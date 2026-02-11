import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:test_eccomarce/core/utls/parse_utls.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final double discountPercentage;

  @HiveField(6)
  final double rating;

  @HiveField(7)
  final int stock;

  @HiveField(8)
  final List<String> tags;

  @HiveField(9)
  final String brand;

  @HiveField(10)
  final String sku;

  @HiveField(11)
  final int weight;

  @HiveField(12)
  final String thumbnail;

  @HiveField(13)
  final List<String> images;

  @HiveField(14)
  final int reviewsCount;

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
    required this.images,
    required this.reviewsCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: ParseUtils.asInt(json['id']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: ParseUtils.asDouble(json['price']),
      discountPercentage: ParseUtils.asDouble(json['discountPercentage']),
      rating: ParseUtils.asDouble(json['rating']),
      stock: ParseUtils.asInt(json['stock']),
      tags: ParseUtils.asList<String>(json['tags']),
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: ParseUtils.asInt(json['weight']),
      thumbnail: json['thumbnail'],
      images: List.from(json['images']),
      reviewsCount: (json['reviews'] as List).length,
    );
  }
  String get priceAfterDiscount =>
      (price * (1 - discountPercentage / 100)).toStringAsFixed(2);
  static List<ProductModel> fromList(List<dynamic> list) {
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

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
        thumbnail: '',
        reviewsCount: 1,
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
