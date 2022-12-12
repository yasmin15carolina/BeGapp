// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/publicGoodsInterface.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/moneyDistribution.dart';

class DistributionExample extends StatefulWidget {
  final PublicGoodsVariables goodsVariables;
  final Function next;
  final bool confirmEnabled;
  DistributionExample(this.goodsVariables, this.next,
      {this.confirmEnabled: true});
  @override
  _DistributionExampleState createState() => _DistributionExampleState();
}

class _DistributionExampleState extends State<DistributionExample> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    return Container(
      child: Stack(children: [
        PublicGoodsTutorial(
          () {},
          widget.goodsVariables,
          tutorialDistElection: true,
        ),
        Container(
            color: Colors.black54,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: MoneyDistribution(
                  100,
                  5,
                  10,
                  () {},
                  tutorial: true,
                  btnEnabled: widget.confirmEnabled,
                ))),
        // Container(
        //   alignment: Alignment.centerLeft,
        //   padding: EdgeInsets.only(left:screenWidth*0.2,top: screenHeight*0.2),
        //   child:Transform.rotate(
        //     angle: -pi*0.3,
        //     child:Image.asset("assets/images/fingerPointer.png",scale:screenHeight*0.04,),
        //   )
        // )
      ]),
    );
  }
}
