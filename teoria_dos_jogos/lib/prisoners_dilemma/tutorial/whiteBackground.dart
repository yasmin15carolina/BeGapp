import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

// ignore: must_be_immutable
class WhiteBackgroundText extends StatelessWidget {
  String txt;
  double fontScale;
  FontWeight fontWeight;
  WhiteBackgroundText(this.txt,
      {this.fontScale: 1, this.fontWeight: FontWeight.bold});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Resize.getWidth(context) * 0.02),
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        AppLocalizations.of(context).translate(txt),
        style: TextStyle(
            fontSize: (MediaQuery.of(context).size.width / 20) * fontScale,
            fontWeight: fontWeight),
        textAlign: TextAlign.center,
      ),
    );
  }
}
