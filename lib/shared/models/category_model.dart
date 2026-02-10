import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable{
  final int id;
  final String name;

  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as int,
    name: json['name'] as String,
  );

  static List<CategoryModel>fromList(List<Map<String, dynamic>> list) => list.map((json) => CategoryModel.fromJson(json)).toList();

    static List<CategoryModel> fromDummyList([int length=10]) => List.generate(length, (index) =>CategoryModel(id: index, name: 'name') ,);

  @override
  List<Object> get props => [id, name];
}