import 'package:flutter/material.dart';
import '../../../widgets/gradient_back.dart';
import '../widgets/card_image_list.dart';
import '../widgets/card_image_with_fab_icon.dart';

class HeaderAppBar extends StatelessWidget {
  double width = 300.0;
  double height = 300.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBack(height: 250.0),
        CardImageList()
      ],
    );
  }

}