// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teoria_dos_jogos/AppLanguage.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/Database.dart';
import 'package:teoria_dos_jogos/classes/popup_message_pg.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/time_taken_tutorial_pg.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/pages/game.page.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/circleIndex.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/tutorialLists.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:teoria_dos_jogos/widgets/popUpWithTimer.dart';

class PublicGoodsTutorialPage extends StatefulWidget {
  final User user;
  final PublicGoodsVariables
      goodsVariables; // = PublicGoodsVariables("",10,10,3,10,0,5,"default","jogo padrão");
  PublicGoodsTutorialPage(this.user, this.goodsVariables);
  @override
  _PublicGoodsTutorialPageState createState() =>
      _PublicGoodsTutorialPageState();
}

class _PublicGoodsTutorialPageState extends State<PublicGoodsTutorialPage> {
  PGTimeTutorial timeTutorial = new PGTimeTutorial();
  List<PopUpMessagePublicGoods> messages = [];
  late DateTime startTutorial;
  List<InterfaceAndText> indexList = [];
  int i = 0;
  late List<Widget> instructions;
  bool btnIsVisible = true;
  bool toCenter = true;
  bool showCoins = false;
  bool clicked = false;
  multipleCoinsEnd() {
    setState(() {
      btnIsVisible = true;
      showCoins = false;
      toCenter = true;
    });
  }

  instructionDelay(int delay) {
    Future.delayed(Duration(seconds: delay), () async {
      setState(() {
        i++;
        if (i < 13 && !indexList[i].enableNext) instructionDelay(5);
        // if(indexList[i].interfaceIndex==4 || indexList[i].interfaceIndex==1 ||
        // (indexList[i].interfaceIndex==2 && !indexList[i].enableNext) ||
        // (indexList[i].interfaceIndex==5 && !indexList[i].enableNext)
        // )instructionDelay();
      });
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    startTutorial = DateTime.now();
    landscapeModeOnly();
    super.initState();
    instructionDelay(3);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black26,
    ));
    portraitModeOnly();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    // var appLanguage = Provider.of<AppLanguage>(context);
    //btnIsVisible=true;
    // i=26;
    // i = 19;
    // i = 23;
    // i = 31;
    // int i = 14;// ao investir..

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double screenWidth = Resize.getWidth(context);
    double screenHeight = Resize.getHeight(context);
    double fontsize = screenHeight / 30;
    indexList = TutorialList.orderInterfaceAndText();
    if (i < 13) btnIsVisible = indexList[i].enableNext;
    next() {
      print("NEXT");
      setState(() {
        clicked = true;
        if (i < indexList.length - 1) {
          i++;
          if (i < 13) instructionDelay(5);
          if (indexList[i].textIndex == 16) {
            btnIsVisible = false;
            showCoins = true;
          }
          if (indexList[i].textIndex == 17) {
            btnIsVisible = false;
            toCenter = false;
            showCoins = true;
          }
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Text(
                      AppLocalizations.of(context).translate('seeAgain'),
                      style: TextStyle(fontSize: fontsize * 1.5),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            timeTutorial.sawMainCountUp();
                            setState(() {
                              instructionDelay(3);
                              i = 0;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('yes'),
                            style: TextStyle(fontSize: fontsize * 1.5),
                          )),
                      TextButton(
                          onPressed: () async {
                            List list = await Database.getPgExperimentMessages(
                                widget.goodsVariables.key);

                            for (int j = 0; j < list.length; j++) {
                              messages.add(
                                  PopUpMessagePublicGoods.fromJson(list[j]));
                            }
                            timeTutorial.setMain(
                                DateTime.now().difference(startTutorial));
                            Navigator.of(context).pop();
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => Dialog(
                                    child: WillPopScope(
                                        onWillPop: () async => false,
                                        child: PopUpWithTimer(
                                            AppLocalizations.of(context)
                                                .translate('waitingPlayers'),
                                            duration: Duration(
                                                seconds: Random().nextInt(10) +
                                                    5), callback: () {
                                          // print(DateTime.now()
                                          // .difference(startTutorial));

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PublicGoodsGamePage(
                                                          widget.user,
                                                          widget.goodsVariables,
                                                          timeTutorial,
                                                          messages)));
                                        }))));
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('no'),
                            style: TextStyle(fontSize: fontsize * 1.5),
                          ))
                    ],
                  ));
        }
      });
      setState(() {
        clicked = false;
      });
    }

    List<Widget> interface = TutorialList.backWidgets(context, next,
        widget.goodsVariables, multipleCoinsEnd, toCenter, showCoins);
    instructions = TutorialList.instructions(
        context, screenHeight, screenWidth, widget.goodsVariables);

    return Scaffold(
        body: Center(
          child: Container(
            width: Resize.getWidth(context),
            height: Resize.getHeight(context),
            child: Stack(
              children: [
                interface[indexList[i].interfaceIndex],
                if (btnIsVisible) instructions[indexList[i].textIndex],
                if (i <= 12 && i > 1)
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth / 2.5),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        CircleIndex(i <= 4 && i >= 2),
                        CircleIndex(indexList[i].interfaceIndex == 3),
                        CircleIndex(i <= 8 && i >= 7),
                        CircleIndex(i <= 10 && i >= 9),
                        CircleIndex(i <= 12 && i >= 11),
                      ],
                    ),
                  ),

                // if(i==0||i==1)
                // Container(
                //   alignment: Alignment.bottomLeft,
                //   child:  TextButton(
                //     color:Colors.teal,
                //     onPressed: (){
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(builder: (context)=>GamePage(widget.user,widget.goodsVariables))
                //                 );
                //     },
                //     child: Text('Pular'),
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child:  TextButton(
                //     color:Colors.teal,
                //     onPressed: (){
                //      setState(() {
                //        i--;
                //      });
                //     },
                //     child: Icon(Icons.arrow_back),
                //   ),
                // )

                // Text(indexList[i].interfaceIndex.toString()+" "+indexList[i].textIndex.toString() +" i:"+i.toString())
              ],
            ),
          ),
        ),
        floatingActionButton: (btnIsVisible)
            ?
            // GestureDetector(
            // onTap: () => (indexList[i].enableNext) ? next  : null,
            // child:
            FloatingActionButton(
                backgroundColor:
                    (indexList[i].enableNext) ? Colors.teal : Colors.grey,
                onPressed: (clicked)
                    ? () {}
                    : (indexList[i].enableNext)
                        ? next
                        : null,
                tooltip: AppLocalizations.of(context).translate('next'),
                child: Icon(Icons.arrow_forward),
              )
            // )
            : null);
  }
}
