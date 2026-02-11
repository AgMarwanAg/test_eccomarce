import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/shared/models/category_model.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

class HomeEntity extends Equatable {
  final List<ProductModel> products;
  final List<CategoryModel> categories;

  const HomeEntity({required this.products, required this.categories});

  @override
  List<Object?> get props => [products, categories];
}
