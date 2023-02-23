import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {

  final IconData iconData;
  final VoidCallback onPressed;

  FloatingActionButtonGreen({
    required this.iconData,
    required this.onPressed
  });

  @override
  State<StatefulWidget> createState() {
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {

  /*void onPressedFav(){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Agregaste a tus favoritos"))
    );

  }*/

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      backgroundColor: const Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      child: Icon(widget.iconData),
    );
  }

}