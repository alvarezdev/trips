
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget{

  final String? hintText;
  TextInputType inputType = TextInputType.text;
  final TextEditingController editingController;
  int? maxLines = 1;

  TextInput({required this.hintText, required this.inputType, required this.editingController, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
      child: TextField(
        controller: editingController,
        keyboardType: inputType,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 15.0,
          fontFamily: "Lato",
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFE5E5E5),
          border: InputBorder.none,
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.all(Radius.circular(9.0))
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E5E5)),
              borderRadius: BorderRadius.all(Radius.circular(9.0))
          )
        ),
      ),
    );

  }

}