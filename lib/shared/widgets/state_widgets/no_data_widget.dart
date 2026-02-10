import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({this.text = 'لا يوجد بيانات', super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
