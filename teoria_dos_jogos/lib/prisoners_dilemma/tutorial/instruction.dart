import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class Instruction extends StatelessWidget {
  final String txtInstruction;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  Instruction(this.txtInstruction,
      {this.alignment: Alignment.topLeft,
      this.padding: const EdgeInsets.all(10),
      this.backgroundColor: const Color.fromRGBO(244, 177, 131, 1)});
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double fontsize = screenHeight / 15;
    return Container(
      alignment: alignment,
      padding: padding,
      child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor,
          ),
          child: Text(
            txtInstruction,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )),
    );
  }
}
