import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends Equatable {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final String name;

  const CategoryModel({required this.url, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(url: json['url'], name: json['name']);

  static List<CategoryModel> fromList(List list) =>
      list.map((json) => CategoryModel.fromJson(json)).toList();

  static List<CategoryModel> fromDummyList([int length = 10]) =>
      List.generate(length, (index) => CategoryModel(url: 'url', name: 'name'));

  @override
  List<Object> get props => [url, name];
}
