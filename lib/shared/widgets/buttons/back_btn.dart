import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';

class BackBtnWidget extends StatelessWidget {
  final bool withBorder;
  const BackBtnWidget({super.key, this.withBorder = false});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: ModalRoute.of(context)?.canPop ?? false,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: withBorder
            ? CircleAvatar(
                backgroundColor: AppColors.navBarColor,
                child: Icon(Icons.arrow_back),
              )
            : Icon(Icons.arrow_back),
      ),
    );
  }
}
