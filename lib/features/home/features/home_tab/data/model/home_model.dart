import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/shared/models/category_model.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

class HomeModel extends Equatable {
  final List<ProductModel> products;
  final List<CategoryModel> categories;

  const HomeModel({required this.products, required this.categories});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
     return HomeModel(
      //this is workaround because api does not Match the ui
      products: ProductModel.fromList(json['products']['products']),
      categories: CategoryModel.fromList(json['categories']),
    );
  }

  static HomeModel fromDummy(){
    return HomeModel(products: ProductModel.fromDummyList(), categories: CategoryModel.fromDummyList());

  }
  @override
  List<Object?> get props => [products, categories];
}
