import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/resultsMatrix.dart';

// ignore: must_be_immutable
class MatrixExample extends StatelessWidget {
  DilemmaVariables variables;

  MatrixExample(this.variables);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.aspectRatio * 150;
    double p = 0.4;
    p = MediaQuery.of(context).size.aspectRatio > 2.0 ? p / 2 : p;
    double fontsize = Resize.getWidth(context) * 0.02;
    // longestSide == width ? longestSide * 0.02 : longestSide * 0.04;
    // ignore: unused_local_variable
    List<MatrixCase> cases = [
      MatrixCase(Colors.red, Colors.red, "dMatrixResult1"),
      MatrixCase(Colors.black, Colors.black, "dMatrixResult2"),
      MatrixCase(Colors.black, Colors.red, "dMatrixResult3"),
      MatrixCase(Colors.red, Colors.black, "dMatrixResult4"),
    ];
    if (true)
      return
          //  ResultsMatrix(p, "", false,variables);
          Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.4),
              child: Row(children: [
                Text(
                  AppLocalizations.of(context).translate('summarize'),
                  style: TextStyle(fontSize: fontsize),
                ),
                Expanded(flex: 1, child: ResultsMatrix(p, "", false, variables))
              ]));
  }
}

class MatrixCase {
  Color you;
  Color other;
  String result;
  MatrixCase(this.you, this.other, this.result);
}
