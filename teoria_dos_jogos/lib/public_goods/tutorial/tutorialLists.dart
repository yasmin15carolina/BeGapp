import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/circlePeople.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/instructionArrowContainer.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/instructionContainer.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/publicGoodsInterface.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/publicGoodsInterfaceCircle.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/publicGoodsInterfaceTimer.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/rectInstruction.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/tutorialDesc.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/tutorialGame.dart';

class InterfaceAndText {
  int textIndex;
  int interfaceIndex;
  bool enableNext;
  InterfaceAndText(this.interfaceIndex, this.textIndex, this.enableNext);
}

class TutorialList {
  static orderInterfaceAndText() {
    List<InterfaceAndText> exibitionOrder = [];
    exibitionOrder.add(InterfaceAndText(0, 0, false));
    exibitionOrder.add(InterfaceAndText(0, 0, true)); //1i
    exibitionOrder.add(InterfaceAndText(1, 0, false)); //2
    exibitionOrder.add(InterfaceAndText(2, 0, false));
    exibitionOrder.add(InterfaceAndText(2, 0, true)); //4
    exibitionOrder.add(InterfaceAndText(3, 0, false));
    exibitionOrder.add(InterfaceAndText(3, 0, true)); //6
    exibitionOrder.add(InterfaceAndText(4, 0, false));
    exibitionOrder.add(InterfaceAndText(4, 0, true));
    exibitionOrder.add(InterfaceAndText(5, 0, false));
    exibitionOrder.add(InterfaceAndText(5, 0, true)); //texto 10

    exibitionOrder.add(InterfaceAndText(11, 0, false));
    exibitionOrder.add(InterfaceAndText(11, 0, true));

    exibitionOrder.add(InterfaceAndText(6, 1, true)); //inicio
    exibitionOrder.add(InterfaceAndText(6, 2, true));
    exibitionOrder.add(InterfaceAndText(6, 3, true));
    exibitionOrder.add(InterfaceAndText(6, 4, true));
    exibitionOrder.add(InterfaceAndText(6, 5, true));
    exibitionOrder.add(InterfaceAndText(6, 6, true));
    exibitionOrder.add(InterfaceAndText(6, 7, true));
    exibitionOrder.add(InterfaceAndText(6, 8, true));

    exibitionOrder.add(InterfaceAndText(7, 9, true)); //circle i17
    exibitionOrder.add(InterfaceAndText(7, 10, true));

    exibitionOrder.add(InterfaceAndText(8, 11, false)); //Tutorial Game
    exibitionOrder.add(InterfaceAndText(8, 0, false));
    exibitionOrder.add(InterfaceAndText(8, 12, false));
    exibitionOrder.add(InterfaceAndText(8, 0, false));

    exibitionOrder.add(InterfaceAndText(9, 13, true));
    exibitionOrder.add(InterfaceAndText(6, 14, true));

    exibitionOrder.add(InterfaceAndText(10, 15, true)); //circle people
    exibitionOrder.add(InterfaceAndText(10, 16, true));
    exibitionOrder.add(InterfaceAndText(10, 17, true));

    return exibitionOrder;
  }

  static backWidgets(
      context, next, goodsVariables, multipleCoinsEnd, toCenter, showCoins) {
    return [
      Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).translate('welcome') +
                "\n" +
                AppLocalizations.of(context).translate('ToPG'),
            style: TextStyle(
              fontSize: (MediaQuery.of(context).size.height / 8),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          )),
      PublicGoodsDesc(
        AppLocalizations.of(context).translate('publicGoodsDesc1'),
        text2: AppLocalizations.of(context).translate('publicGoodsDesc2'),
        text2Color: Colors.transparent,
      ),
      PublicGoodsDesc(
        AppLocalizations.of(context).translate('publicGoodsDesc1'),
        text2: AppLocalizations.of(context).translate('publicGoodsDesc2'),
      ),
      PublicGoodsDesc(
        AppLocalizations.of(context).translate('publicGoodsDesc3.1'),
        redText: AppLocalizations.of(context).translate('publicGoodsDesc3.2'),
      ),
      PublicGoodsDesc(
        AppLocalizations.of(context).translate('publicGoodsDesc4'),
      ),
      PublicGoodsDesc(
        AppLocalizations.of(context).translate('pGAnonymousActivity'),
      ),
      PublicGoodsTutorial(null, goodsVariables),
      PublicGoodsCircle(goodsVariables),
      TutorialGamePage(next, goodsVariables),
      PublicGoodsTimer(goodsVariables),
      CirclePeople(showCoins, multipleCoinsEnd, toCenter, goodsVariables),
      PublicGoodsDesc(
          AppLocalizations.of(context).translate('publicGoodsDesc5')),
    ];
  }

  static instructions(
      context, screenHeight, screenWidth, PublicGoodsVariables goodsVariables) {
    double containerWidth = screenWidth * 0.6;
    return [
      SizedBox(
        height: 0,
      ),

      InstructionArrow(
        AppLocalizations.of(context).translate('pGInstruction1'),
        true,
        Icons.arrow_downward,
        top: 5,
        left: screenWidth * 0.3,
        right: screenWidth * 0.3,
        bottom: 0,
        width: null,
      ),

      InstructionArrow(
        AppLocalizations.of(context).translate('pGInstruction2'),
        false,
        Icons.arrow_back,
        top: screenHeight * 0.65,
        left: screenWidth * 0.15,
        right: 0,
        bottom: 0,
        width: screenWidth * 0.5,
      ),

      InstructionArrow(
        AppLocalizations.of(context).translate('pGInstruction3'),
        false,
        Icons.arrow_back,
        top: screenHeight * 0.65,
        left: screenWidth * 0.18,
        right: 0,
        bottom: 0,
        width: screenWidth * 0.6,
      ),

      InstructionArrow(
        AppLocalizations.of(context).translate('pGInstruction4.1') +
            goodsVariables.maxTokens.toString() +
            AppLocalizations.of(context).translate('pGInstruction4.2'),
        false,
        Icons.arrow_back,
        top: screenHeight * 0.75,
        left: screenWidth * 0.15,
        right: 0,
        bottom: 0,
        width: screenWidth * 0.4,
      ),

      InstructionArrow(AppLocalizations.of(context).translate('pGInstruction5'),
          false, Icons.arrow_back,
          top: screenHeight * 0.38,
          left: screenWidth * 0.17,
          right: 0,
          bottom: screenHeight * 0.3,
          width: screenWidth * 0.6),

      InstructionArrow(AppLocalizations.of(context).translate('pGInstruction6'),
          false, Icons.arrow_back,
          top: screenHeight * 0.38,
          left: screenWidth * 0.17,
          right: 0,
          bottom: screenHeight * 0.25,
          width: screenWidth * 0.6),

      InstructionArrow(AppLocalizations.of(context).translate('pGInstruction7'),
          false, Icons.arrow_forward,
          top: 5,
          left: screenWidth * 0.23,
          right: 0,
          bottom: screenHeight * 0.4,
          width: screenWidth * 0.5),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction8'),
        false,
        null,
        width: screenWidth * 0.55,
      ),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction9'),
        false,
        null,
        width: screenWidth * 0.3,
        alignment: Alignment.centerLeft,
      ),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction10'),
        false,
        null,
        width: screenWidth * 0.25,
        alignment: Alignment.centerLeft,
      ),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction11'),
        false,
        null,
        width: screenWidth * 0.22,
        alignment: Alignment.centerRight,
      ),

      InstructionRect(
        AppLocalizations.of(context).translate('pGInstruction12'),
        // "See that the amount of tokens that appeared here went to your wallet, added to what was left in “My tokens”",
        alignment: Alignment.center,
      ),

      // SizedBox(height: 0,),

      InstructionArrow(
        AppLocalizations.of(context).translate('pGInstruction13'),
        false,
        Icons.arrow_back,
        top: 5,
        left: screenWidth * 0.15,
        right: screenWidth * 0,
        bottom: screenHeight * 0.7,
        width: containerWidth,
      ),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction14'),
        false,
        null,
        width: containerWidth,
      ),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction15'),
        false,
        null,
        width: containerWidth * 1.2,
        alignment: Alignment.topCenter,
      ),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction16'),
        false,
        null,
        width: containerWidth * 1.2,
        alignment: Alignment.topCenter,
      ),

      Instruction(
        AppLocalizations.of(context).translate('pGInstruction17'),
        false,
        null,
        width: containerWidth * 1.2,
        alignment: Alignment.topCenter,
      ),
    ];
  }
}
