import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/dilemmaCard.dart';

import 'animatedResult.dart';

// ignore: must_be_immutable
class ResultsMatrix extends StatefulWidget {
  double p;
  bool animate;
  String result;
  DilemmaVariables variables;
  ResultsMatrix(this.p, this.result, this.animate, this.variables);
  @override
  _ResultsMatrixState createState() => _ResultsMatrixState();
}

class _ResultsMatrixState extends State<ResultsMatrix> {
  double opacity = 0.3;
  double opInvisible = 0.0;
  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double height = Resize.getHeight(context);
    double width = Resize.getWidth(context);
    // width = (ratio > 2) ? width = height * 2 : width;
    double fontsize = width * 0.02;
    // longestSide == width ? longestSide * 0.02 : longestSide * 0.04;
    opacity = widget.result == "" ? 1 : 0.3;
    matrixNoResultsElements() {
      return [
        Opacity(
            opacity: opacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context).translate('yourGain'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontsize),
                ),
                Text(
                  AppLocalizations.of(context).translate('otherGain'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontsize),
                ),
              ],
            )),
        Opacity(
            opacity: opacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DilemmaCard(
                  color: Colors.red,
                  proportion: widget.p,
                  txt: "${widget.variables.bothCooperate}",
                ),
                DilemmaCard(
                  color: Colors.red,
                  proportion: widget.p,
                  txt: "${widget.variables.bothCooperate}",
                ),
              ],
            )),
        Opacity(
            opacity: opacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DilemmaCard(
                    color: Colors.black,
                    proportion: widget.p,
                    txt: "${widget.variables.bothDefect}"),
                DilemmaCard(
                    color: Colors.black,
                    proportion: widget.p,
                    txt: "${widget.variables.bothDefect}"),
              ],
            )),
        Opacity(
          opacity: opacity,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            DilemmaCard(
                color: Colors.black,
                proportion: widget.p,
                txt: "${widget.variables.defectWin}"),
            DilemmaCard(
                color: Colors.red,
                proportion: widget.p,
                txt: "${widget.variables.cooperateLoses}"),
          ]),
        ),
        Opacity(
            opacity: opacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DilemmaCard(
                    color: Colors.red,
                    proportion: widget.p,
                    txt: "${widget.variables.cooperateLoses}"),
                DilemmaCard(
                    color: Colors.black,
                    proportion: widget.p,
                    txt: "${widget.variables.defectWin}"),
              ],
            )),
      ];
    }

    matrixResultsElements() {
      return [
        Opacity(
            opacity: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context).translate('yourGain'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontsize),
                ),
                Text(
                  AppLocalizations.of(context).translate('otherGain'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontsize),
                ),
              ],
            )),
        Opacity(
            opacity: widget.result == "bothCooperate" ? 1 : 0,
            child: AnimatedResult(
              p: widget.p,
              offset: Offset(width * 0.335, -height * 0.3),
              color1: Colors.red,
              color2: Colors.red,
              value1: 5,
              value2: 5,
            )),
        Opacity(
            opacity: widget.result == "bothCompete" ? 1 : 0,
            child: AnimatedResult(
              p: widget.p,
              offset: Offset(width * 0.335, -height * 0.08),
              color1: Colors.black,
              color2: Colors.black,
              value1: 2,
              value2: 2,
            )),
        Opacity(
            opacity: widget.result == "userWins" ? 1 : 0,
            child: AnimatedResult(
              p: widget.p,
              offset: Offset(width * 0.335, height * 0.15),
              color1: Colors.black,
              color2: Colors.red,
              value1: 6,
              value2: 1,
            )),
        Opacity(
            opacity: widget.result == "userLoses" ? 1 : 0,
            child: AnimatedResult(
              p: widget.p,
              offset: Offset(width * 0.335, height * 0.375),
              color1: Colors.red,
              color2: Colors.black,
              value1: 1,
              value2: 6,
            )),
      ];
    }

    return Container(
        child: Stack(
      children: [
        if (ratio > 7.0)
          Scrollbar(
              child: ListView(
            children: matrixNoResultsElements(),
          ))
        else
          Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: matrixNoResultsElements()),
        if (widget.result != "")
          if (ratio > 7.0)
            Scrollbar(
                child: ListView(
              children: matrixResultsElements(),
            ))
          else
            Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: matrixResultsElements()),
      ],
    ));
  }
}
