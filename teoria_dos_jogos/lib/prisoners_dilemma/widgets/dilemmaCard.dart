// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

// ignore: must_be_immutable
class DilemmaCard extends StatelessWidget {
  Color color;
  Color borderColor;
  double proportion;
  String txt;
  String txtTitle;
  double fontScale;
  DilemmaCard(
      {this.color: Colors.transparent,
      this.borderColor: Colors.transparent,
      this.proportion: 0.5,
      this.txt: "",
      this.txtTitle: "",
      this.fontScale: 1});
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    double longestSide = MediaQuery.of(context).size.longestSide;
    double width = screenWidth * 0.075;
    // longestSide == screenWidth ? longestSide * 0.075 : longestSide * 0.2;
    double height = screenWidth * 0.1;
    // longestSide == screenWidth ? longestSide * 0.1 : longestSide * 0.2;
    double fontsize = screenWidth * 0.05;
    // longestSide == screenWidth ? longestSide * 0.05 : longestSide * 0.08;
    //double v = 0.45;
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor, width: 2)),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (txtTitle != "")
            Text(
              txtTitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: fontsize * 0.35),
            ),
          Text(
            txt,
            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color:
                    color == Colors.transparent ? Colors.black : Colors.white,
                fontSize: fontScale * fontsize),
          ),
        ]));
  }
}
