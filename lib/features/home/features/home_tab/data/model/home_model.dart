import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/entities/home_entity.dart';
import 'package:test_eccomarce/shared/models/category_model.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

part 'home_model.g.dart';

@HiveType(typeId: 2)
class HomeModel extends Equatable {
  @HiveField(0)
  final List<ProductModel> products;

  @HiveField(1)
  final List<CategoryModel> categories;

  const HomeModel({required this.products, required this.categories});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      //this is workaround because api does not Match the ui
      products: ProductModel.fromList(json['products']['products']),
      categories: CategoryModel.fromList(json['categories']),
    );
  }

  static HomeModel fromDummy() {
    return HomeModel(
      products: ProductModel.fromDummyList(),
      categories: CategoryModel.fromDummyList(),
    );
  }

  HomeEntity toEntity() {
    return HomeEntity(products: products, categories: categories);
  }

  @override
  List<Object?> get props => [products, categories];
}
