import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial_distribution/instruction.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/electionAnimation.dart';

import 'electionExample.dart';
import 'gameScreen.dart';

class InterfaceAndText {
  int textIndex;
  int interfaceIndex;
  bool enableNext;
  InterfaceAndText(this.interfaceIndex, this.textIndex, this.enableNext);
}

class TutorialLists {
  static orderInterfaceAndText() {
    List<InterfaceAndText> exibitionOrder = [];
    exibitionOrder.add(InterfaceAndText(0, 1, true));
    exibitionOrder.add(InterfaceAndText(0, 2, true));
    exibitionOrder.add(InterfaceAndText(3, 3, true));
    exibitionOrder.add(InterfaceAndText(1, 9, true));
    exibitionOrder.add(InterfaceAndText(2, 4, true));
    exibitionOrder.add(InterfaceAndText(2, 5, true));
    exibitionOrder.add(InterfaceAndText(2, 6, true));
    exibitionOrder.add(InterfaceAndText(2, 7, true));
    exibitionOrder.add(InterfaceAndText(3, 8, true));

    return exibitionOrder;
  }

  static interfaces(context, PublicGoodsVariables goodsVariables, next) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    return [
      Container(
        color: Colors.white,
      ),
      Stack(children: [
        GameScreen(goodsVariables, next, false),
        ElectionAnimation(
          screenHeight / 2,
          fontSize: screenWidth / 10,
          onEndAnimation: () {},
        )
      ]),
      ElectionExample(goodsVariables, next),
      GameScreen(goodsVariables, next, true),
    ];
  }

  static instructions(context, PublicGoodsVariables goodsVariables) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    return [
      SizedBox(),
      Instruction(
        AppLocalizations.of(context).translate("PGElectiontionInstruction1"),
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 10),
        backgroundColor: Colors.red.withOpacity(0.8),
      ),
      Instruction(
        AppLocalizations.of(context).translate("PGElectiontionInstruction2"),
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 10),
        backgroundColor: Colors.red.withOpacity(0.8),
      ),
      Stack(
        children: [
          Instruction(
            AppLocalizations.of(context)
                .translate("PGElectiontionInstruction3"),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.15, vertical: 10),
          ),
          Container(
              child: Icon(
                Icons.arrow_upward,
                size: screenWidth * 0.1,
                color: Color.fromRGBO(244, 177, 131, 1),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: screenHeight * 0.3))
        ],
      ),
      Instruction(
        AppLocalizations.of(context).translate("PGElectiontionInstruction4.1") +
            goodsVariables.timeElection.toString() +
            AppLocalizations.of(context)
                .translate("PGElectiontionInstruction4.2"),
        padding: EdgeInsets.only(
            left: screenWidth * 0.06,
            right: screenWidth * 0.3,
            top: screenHeight * 0.5),
      ),
      Instruction(
          AppLocalizations.of(context).translate("PGElectiontionInstruction5"),
          padding: EdgeInsets.only(
              left: screenWidth * 0.01,
              right: screenWidth * 0.15,
              top: screenHeight * 0.7)),
      Instruction(
          AppLocalizations.of(context).translate("PGElectiontionInstruction6"),
          padding: EdgeInsets.only(
              left: screenWidth * 0.06,
              right: screenWidth * 0.3,
              top: screenHeight * 0.5)),
      Instruction(
          AppLocalizations.of(context).translate("PGElectiontionInstruction7"),
          padding: EdgeInsets.only(
              left: screenWidth * 0.06,
              right: screenWidth * 0.3,
              top: screenHeight * 0.5)),
      Stack(
        children: [
          Instruction(
              AppLocalizations.of(context)
                  .translate("PGElectiontionInstruction8"),
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: screenWidth * 0.3,
                  right: screenWidth * 0.25,
                  bottom: screenHeight * 0.1)),
          Container(
              child: Icon(
                Icons.arrow_forward,
                size: screenWidth * 0.1,
                color: Color.fromRGBO(244, 177, 131, 1),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: screenWidth * 0.58, bottom: screenHeight * 0.1))
        ],
      ),
      SizedBox()
    ];
  }
}
