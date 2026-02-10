import 'package:equatable/equatable.dart';

class HomeModel extends Equatable {
  final String name;

  const HomeModel({required this.name});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(name: json['']);
  }

  factory HomeModel.fromDummyJson() {
     return HomeModel(name: 'name');
  }
  @override
  List<Object?> get props => [name];
}
