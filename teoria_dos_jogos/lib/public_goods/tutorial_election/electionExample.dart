import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial_election/gameScreen.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/election.dart';

class ElectionExample extends StatefulWidget {
  final PublicGoodsVariables goodsVariables;
  final Function next;
  ElectionExample(this.goodsVariables, this.next);
  @override
  _ElectionExampleState createState() => _ElectionExampleState();
}

class _ElectionExampleState extends State<ElectionExample> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getHeight(context);
    return Container(
        child: Container(
      child: Stack(children: [
        GameScreen(widget.goodsVariables, widget.next, false),
        Container(
            color: Colors.black54,
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.1, horizontal: screenWidth * 0.05),
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: ElectionPopUp(
                  0,
                  widget.goodsVariables.notRealPlayers,
                  widget.goodsVariables.timeElection,
                  () {},
                  () {},
                  tutorial: true,
                ))),
      ]),
    ));
  }
}
