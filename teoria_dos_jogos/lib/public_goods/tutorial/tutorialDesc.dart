import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class PublicGoodsDesc extends StatelessWidget {
  final String text1;
  final String text2;
  final Color text2Color;
  final String redText;
  PublicGoodsDesc(this.text1,
      {this.redText: "", this.text2: "", this.text2Color: Colors.black});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                  fontSize: (Resize.getHeight(context) / 12), height: 1.2),
              children: [
                TextSpan(
                    text: text1,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                if (redText != "")
                  TextSpan(
                      text: redText,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                if (text2 != "")
                  TextSpan(
                      text: "\n\n" + text2,
                      style: TextStyle(
                          color: text2Color, fontWeight: FontWeight.bold)),
              ]),
        ));
  }
}
