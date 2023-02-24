import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/floating_action_button_green.dart';
import 'package:cached_network_image/cached_network_image.dart';

class  CardImageWithFabIcon extends StatelessWidget {

  final double height;
  final double width;
  double left = 20.0;
  final VoidCallback? onPressedFabIcon;
  final IconData iconData;
  final XFile? image;
  bool? internet = true;

  CardImageWithFabIcon({
    required this.onPressedFabIcon,
    required this.image,
    required this.width,
    required this.height,
    required this.iconData,
    this.internet
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: left),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
            //image: AssetImage(pathImage)
            //image: image!.image,
            image: CachedNetworkImageProvider(image!.path)
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: const <BoxShadow>[
          BoxShadow (
            color:  Colors.black38,
            blurRadius: 15.0,
            offset: Offset(0.0, 7.0)
          )
        ]

      ),
    );

    return Stack(
      alignment: const Alignment(0.9,1.1),
      children: [
        card,
        FloatingActionButtonGreen(
          onPressed: onPressedFabIcon!,
          iconData: iconData,
        )
      ],
    );
  }

}