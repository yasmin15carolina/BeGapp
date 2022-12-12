import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/tutorial/resultExample.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/tutorial/whiteBackground.dart';

import 'gameExample.dart';
import 'instruction.dart';
import 'matrixExample.dart';

class InterfaceAndText {
  int textIndex;
  int interfaceIndex;
  bool enableNext;
  InterfaceAndText(this.interfaceIndex, this.textIndex,
      {this.enableNext: true});
}

class WidgetsList {
  static orderInterfaceAndText() {
    List<InterfaceAndText> exibitionOrder = [];
    exibitionOrder.add(InterfaceAndText(0, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(1, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(2, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(3, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(4, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(5, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(6, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(7, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(8, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(9, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(10, 0, enableNext: true));
    exibitionOrder.add(
        InterfaceAndText(11, 0, enableNext: true)); //inicio do jogo tutorial
    exibitionOrder.add(InterfaceAndText(12, 1, enableNext: true));
    exibitionOrder.add(InterfaceAndText(12, 2, enableNext: true));
    exibitionOrder.add(InterfaceAndText(13, 3,
        enableNext: false)); //escolha vermelha - vermelha
    exibitionOrder.add(InterfaceAndText(13, 4, enableNext: false));
    exibitionOrder.add(InterfaceAndText(13, 5, enableNext: false));
    exibitionOrder
        .add(InterfaceAndText(13, 6, enableNext: false)); //preta - preta
    exibitionOrder.add(InterfaceAndText(13, 4, enableNext: false));
    exibitionOrder.add(InterfaceAndText(13, 7, enableNext: false));
    exibitionOrder
        .add(InterfaceAndText(13, 11, enableNext: false)); //preta - vermelha
    exibitionOrder.add(InterfaceAndText(13, 4, enableNext: false));
    exibitionOrder.add(InterfaceAndText(13, 8, enableNext: false));
    exibitionOrder
        .add(InterfaceAndText(13, 10, enableNext: false)); //vermelha - preta
    exibitionOrder.add(InterfaceAndText(13, 4, enableNext: false));
    exibitionOrder.add(InterfaceAndText(13, 9, enableNext: false));
    exibitionOrder.add(InterfaceAndText(14, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(15, 0, enableNext: true));
    exibitionOrder.add(InterfaceAndText(16, 0, enableNext: true));
    return exibitionOrder;
  }

  static backWidgets(DilemmaVariables dilemmaVariables, context, next) {
    double fontScale = 2;
    return [
      WhiteBackgroundText(
        "dInstruction1",
        fontWeight: FontWeight.bold,
        fontScale: fontScale,
      ),
      WhiteBackgroundText(
        "dInstruction2",
      ),
      WhiteBackgroundText("dInstruction3"),
      WhiteBackgroundText(
        "dInstruction4",
      ),
      WhiteBackgroundText(
        "dInstruction5",
      ),
      DilemmaResultExample("dYourChoice1", "dOtherChoice1", "dResult1",
          Colors.red, Colors.red, dilemmaVariables),
      DilemmaResultExample("dYourChoice2", "dOtherChoice2", "dResult2",
          Colors.black, Colors.black, dilemmaVariables),
      DilemmaResultExample("dYourChoice3", "dOtherChoice3", "dResult3",
          Colors.black, Colors.red, dilemmaVariables),
      DilemmaResultExample("dYourChoice4", "dOtherChoice4", "dResult4",
          Colors.red, Colors.black, dilemmaVariables),
      WhiteBackgroundText(
        "dInstruction6",
      ),
      MatrixExample(dilemmaVariables),
      WhiteBackgroundText(
        "dInstruction7",
      ),
      DilemmaGameTutorial(
          dilemmaVariables,
          AppLocalizations.of(context).translate('yourChoice'),
          AppLocalizations.of(context).translate('otherChoice'),
          false,
          next),
      DilemmaGameTutorial(
          dilemmaVariables,
          AppLocalizations.of(context).translate('yourChoice'),
          AppLocalizations.of(context).translate('otherChoice'),
          true,
          next),
      WhiteBackgroundText(
        "dInstruction17",
      ),
      WhiteBackgroundText(
        "dInstruction18",
      ),
      WhiteBackgroundText(
        "dInstruction19",
      ),

      // DilemmaGameTutorial(dilemmaVariables,AppLocalizations.of(context).translate('yourChoice'),AppLocalizations.of(context).translate('otherChoice'),false,true,next,1),
      // DilemmaGameTutorial(dilemmaVariables,AppLocalizations.of(context).translate('yourChoice'),AppLocalizations.of(context).translate('otherChoice'),false,true,next,0),
      // DilemmaGameTutorial(dilemmaVariables,AppLocalizations.of(context).translate('yourChoice'),AppLocalizations.of(context).translate('otherChoice'),true,false,next,1),
    ];
  }

  static instructions(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return [
      SizedBox(height: 0),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction8'),
        padding: EdgeInsets.only(left: width * 0.11, top: height * 0.05),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction9'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.05, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction10'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction11'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction12'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction13'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction14'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction15'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction16'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction10') +
            " " +
            AppLocalizations.of(context).translate('again'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
      Instruction(
        AppLocalizations.of(context).translate('dInstruction13') +
            " " +
            AppLocalizations.of(context).translate('again'),
        padding: EdgeInsets.only(
            left: width * 0.02, top: height * 0.03, right: width * 0.3),
      ),
    ];
  }
}
