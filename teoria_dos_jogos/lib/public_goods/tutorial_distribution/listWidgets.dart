import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial_distribution/instruction.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial_distribution/players_moneyBag.dart';

import 'distributionExample.dart';

class InterfaceAndText {
  int textIndex;
  int interfaceIndex;
  bool enableNext;
  InterfaceAndText(this.interfaceIndex, this.textIndex, this.enableNext);
}

class TutorialLists {
  static orderInterfaceAndText() {
    List<InterfaceAndText> exibitionOrder = [];
    exibitionOrder.add(InterfaceAndText(1, 1, true));
    exibitionOrder.add(InterfaceAndText(1, 2, true));
    exibitionOrder.add(InterfaceAndText(1, 3, true));
    exibitionOrder.add(InterfaceAndText(0, 4, true));

    exibitionOrder.add(InterfaceAndText(2, 5, true));
    exibitionOrder.add(InterfaceAndText(2, 6, true));
    exibitionOrder.add(InterfaceAndText(2, 7, true));
    exibitionOrder.add(InterfaceAndText(3, 8, true)); //
    exibitionOrder.add(InterfaceAndText(3, 9, true));
    exibitionOrder.add(InterfaceAndText(3, 10, true));
    //  exibitionOrder.add(InterfaceAndText(2,11,true));
    //  exibitionOrder.add(InterfaceAndText(3,0,true));

    return exibitionOrder;
  }

  static interfaces(screenWidth, goodsVariables, next) {
    return [
      Container(
        color: Colors.white,
      ),
      PlayersRibRepresentation(-screenWidth / 2.32),
      DistributionExample(
        goodsVariables,
        next,
        confirmEnabled: false,
      ),
      DistributionExample(goodsVariables, next),
    ];
  }

  static instructions(context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    return [
      SizedBox(),
      Instruction(
        AppLocalizations.of(context).translate("PGDistributionInstruction1"),
        alignment: Alignment.topCenter,
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 10),
      ),
      Instruction(
        AppLocalizations.of(context).translate("PGDistributionInstruction2"),
        alignment: Alignment.topCenter,
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 10),
      ),
      Instruction(
        AppLocalizations.of(context).translate("PGDistributionInstruction3"),
        alignment: Alignment.topCenter,
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 10),
      ),
      Instruction(
        AppLocalizations.of(context).translate("PGDistributionInstruction4"),
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 10),
      ),
      Stack(
        children: [
          Instruction(
              AppLocalizations.of(context)
                  .translate("PGDistributionInstruction5"),
              padding: EdgeInsets.only(
                  left: screenWidth * 0.4,
                  right: screenWidth * 0.01,
                  top: screenHeight * 0.23)),
          Container(
              child: Icon(
                Icons.arrow_upward,
                size: screenWidth * 0.1,
                color: Color.fromRGBO(244, 177, 131, 1),
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                  right: screenWidth * 0.25, bottom: screenHeight * 0.12))
        ],
      ),
      Instruction(
          AppLocalizations.of(context).translate("PGDistributionInstruction6"),
          padding: EdgeInsets.only(
              left: screenWidth * 0.35,
              right: screenWidth * 0.1,
              bottom: screenHeight * 0.18)),
      Instruction(
          AppLocalizations.of(context).translate("PGDistributionInstruction7"),
          padding: EdgeInsets.only(
              left: screenWidth * 0.35,
              right: screenWidth * 0.1,
              bottom: screenHeight * 0.18)),
      Instruction(
          AppLocalizations.of(context).translate("PGDistributionInstruction8"),
          // "A quantia escolhida irá para sua carteira quando clicar em confirmar",
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: screenWidth * 0.18,
              right: screenWidth * 0.18,
              top: screenHeight * 0.1)),
      Instruction(
          AppLocalizations.of(context).translate("PGDistributionInstruction9"),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.2,
          )),
      Instruction(
          AppLocalizations.of(context).translate("PGDistributionInstruction10"),
          padding: EdgeInsets.only(
            left: screenWidth * 0.2,
            right: screenWidth * 0.2,
            top: screenHeight * 0.1,
          )),
    ];
  }
}
