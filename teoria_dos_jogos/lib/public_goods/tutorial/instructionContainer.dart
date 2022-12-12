import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class Instruction extends StatelessWidget {
  final String instructiontxt;
  final bool column;
  final IconData? icon;
  final double? width;
  final Alignment? alignment;
  Instruction(this.instructiontxt, this.column, this.icon,
      {this.width, this.alignment});
  @override
  Widget build(BuildContext context) {
    double screenWidth = Resize.getWidth(context);
    double screenHeight = Resize.getHeight(context);
    double fontsize = screenHeight / 25;
    return Container(
      // color: Colors.green.withOpacity(0.8),
      alignment: (alignment == null) ? Alignment.center : alignment,
      child: Container(
        padding: EdgeInsets.all(5),
        width: (width == null) ? screenWidth / 1.9 : width,
        //padding: EdgeInsets.all(5),
        //alignment: Alignment.center,
        decoration: BoxDecoration(
          // shape:BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.red.withOpacity(0.8),
        ),
        child: Text(
          instructiontxt,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontsize * 1.7,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
