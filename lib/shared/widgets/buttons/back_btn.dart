import 'package:flutter/material.dart';

class BackBtnWidget extends StatelessWidget {
  const BackBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: ModalRoute.of(context)?.canPop ?? false,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back)
      ),
    );
  }
}
