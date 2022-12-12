import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:teoria_dos_jogos/classes/time_taken_tutorial_pg.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial_distribution/listWidgets.dart';
import 'package:teoria_dos_jogos/widgets/popUpWithTimer.dart';

class DistributionTutorial extends StatefulWidget {
  final PublicGoodsVariables
      goodsVariables; // = PublicGoodsVariables("",10,10,3,50,0,5,"default2","jogo 2",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01"),false,10,10,2,10,5,4,3,1);
  final Function nextRound;
  final PGTimeTutorial timeTutorial;
  DistributionTutorial(this.goodsVariables, this.nextRound, this.timeTutorial);
  @override
  _DistributionTutorialState createState() => _DistributionTutorialState();
}

class _DistributionTutorialState extends State<DistributionTutorial> {
  int i = 0;
  List<Widget> interfaces = [];
  List<Widget> instructions = [];
  List<InterfaceAndText> exibitionOrder = [];
  late DateTime startTutorial;

  @override
  void initState() {
    startTutorial = DateTime.now();
    landscapeModeOnly();
    super.initState();
  }

  @override
  void dispose() {
    // portraitModeOnly();
    super.dispose();
  }

  next(context) {
    double screenHeight = Resize.getHeight(context);
    double fontsize = screenHeight / 30;
    if (i < exibitionOrder.length - 1) {
      setState(() {
        i++;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  AppLocalizations.of(context).translate('seeAgain'),
                  style: TextStyle(fontSize: fontsize * 1.5),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        widget.timeTutorial.sawDistributionCountUp();
                        setState(() {
                          i = 0;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('yes'),
                        style: TextStyle(fontSize: fontsize * 1.5),
                      )),
                  TextButton(
                      onPressed: () {
                        widget.timeTutorial.setDistribution(
                            DateTime.now().difference(startTutorial));
                        Navigator.of(context).pop();
                        // Navigator.of(context).pop();
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (dContext) {
                              return Dialog(
                                  child: WillPopScope(
                                      onWillPop: () async => false,
                                      child: PopUpWithTimer(
                                          AppLocalizations.of(dContext)
                                              .translate('waitingPlayers'),
                                          duration: Duration(
                                              seconds: Random().nextInt(10) +
                                                  5), callback: () {
                                        Navigator.of(dContext).pop();
                                        showDialog(
                                            barrierDismissible: false,
                                            context: dContext,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                  child: WillPopScope(
                                                      onWillPop: () async =>
                                                          false,
                                                      child: Flex(
                                                          direction:
                                                              Axis.vertical,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            PopUpWithTimer(
                                                              AppLocalizations.of(
                                                                      dialogContext)
                                                                  .translate(
                                                                      'choosingAdmin'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          5),
                                                              callback: () {
                                                                showDialog(
                                                                    barrierDismissible:
                                                                        false,
                                                                    context:
                                                                        dialogContext,
                                                                    builder: (context) =>
                                                                        Dialog(
                                                                            child:
                                                                                WillPopScope(
                                                                          onWillPop: () async =>
                                                                              false,
                                                                          child:
                                                                              PopUpWithTimer(
                                                                            AppLocalizations.of(dialogContext).translate('congratsAdmin'),
                                                                            duration:
                                                                                Duration(seconds: 4),
                                                                            callback:
                                                                                widget.nextRound,
                                                                          ),
                                                                        )));
                                                              },
                                                            ),
                                                            CircularProgressIndicator(),
                                                          ])));
                                            });
                                      })));
                            });
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('no'),
                        style: TextStyle(fontSize: fontsize * 1.5),
                      ))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    interfaces = TutorialLists.interfaces(
        Resize.getWidth(context), widget.goodsVariables, next);
    instructions = TutorialLists.instructions(context);
    exibitionOrder = TutorialLists.orderInterfaceAndText();
    // i=3;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
            body: Center(
              child: Container(
                width: Resize.getWidth(context),
                height: Resize.getHeight(context),
                child: Stack(
                  children: [
                    interfaces[exibitionOrder[i].interfaceIndex],
                    instructions[exibitionOrder[i].textIndex],
                    //  DistributionSimulation(null,widget.goodsVariables)
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors
                  .teal, //(indexList[i].enableNext)? Colors.teal:Colors.grey,
              onPressed: () => next(context),
              tooltip: AppLocalizations.of(context).translate('next'),
              child: Icon(Icons.arrow_forward),
            )));
  }
}
