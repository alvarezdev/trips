import 'package:flutter/material.dart';


class ButtonGreen extends StatefulWidget {

  String text = "";
  double width = 0.0;
  double height = 0.0;
  VoidCallback onPressed;

  ButtonGreen({super.key, required this.text, required this.onPressed, required this.width, required this.height});

  @override
  State<StatefulWidget> createState() {
    return _ButtonGreen();
  }
}

class _ButtonGreen extends State<ButtonGreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.only(
            top: 30.0,
            left: 20.0,
            right: 20.0
        ),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: const LinearGradient(
                colors: [
                  Color(0xFFA7FF84),
                  Color(0xFF1CBB78)
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp
            )
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 18.0,
                fontFamily: "Lato",
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}