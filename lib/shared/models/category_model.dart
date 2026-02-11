import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable{
  final String url;
  final String name;

  const CategoryModel({required this.url, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    url: json['url']  ,
    name: json['name'] ,
  );

  static List<CategoryModel>fromList(List list) => list.map((json) => CategoryModel.fromJson(json)).toList();

    static List<CategoryModel> fromDummyList([int length=10]) => List.generate(length, (index) =>CategoryModel(url: 'url', name: 'name') ,);

  @override
  List<Object> get props => [url, name];
}