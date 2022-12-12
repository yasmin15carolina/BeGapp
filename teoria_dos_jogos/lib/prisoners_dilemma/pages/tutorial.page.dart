import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/Database.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:teoria_dos_jogos/classes/time_taken_tutorial_pd.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/popup_message_pd.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/tutorial/tutorialList.dart';
import 'package:teoria_dos_jogos/widgets/popUpWithTimer.dart';

import 'game.page.dart';

class DilemmaTutorialPage extends StatefulWidget {
  final DilemmaVariables variables;
  final User user;
  DilemmaTutorialPage(this.user, this.variables);
  @override
  _DilemmaTutorialPageState createState() => _DilemmaTutorialPageState();
}

class _DilemmaTutorialPageState extends State<DilemmaTutorialPage> {
  int startDoTutorial = 10;
  int i = 0;
  // int i = 12;
  List<PopUpMessagePrisonersDilemma> messages = [];
  late List<InterfaceAndText> exibitionOrder;
  late DateTime startTutorial;
  PDTimeTutorial timeTutorial = new PDTimeTutorial();
  @override
  void initState() {
    landscapeModeOnly();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    startTutorial = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    portraitModeOnly();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    // i = 28;
    List<Widget> instructions = WidgetsList.instructions(context);
    exibitionOrder = WidgetsList.orderInterfaceAndText();
    landscapeModeOnly();
    double screenHeight = Resize.getHeight(context);
    double fontsize = screenHeight / 30;
    next() {
      if (i < exibitionOrder.length - 1) {
        // if(i<9)
        setState(() {
          i++;
        });
        // else
        // setState(() {
        //   i=5;
        // });
      } else
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
                          timeTutorial.sawTutorialCountUp();
                          setState(() {
                            i = startDoTutorial;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context).translate('yes'),
                          style: TextStyle(fontSize: fontsize * 1.5),
                        )),
                    TextButton(
                        onPressed: () async {
                          //pega as mensagens a serem exibidas ao longo do jogo(se houverem)
                          List list = await Database.getPdExperimentMessages(
                              widget.variables.key!);

                          for (int j = 0; j < list.length; j++) {
                            messages.add(
                                PopUpMessagePrisonersDilemma.fromJson(list[j]));
                          }
                          timeTutorial.setTutorial(
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
                                        //     .difference(startTutorial));
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DilemmaGamePage(
                                                        widget.user,
                                                        widget.variables,
                                                        timeTutorial,
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'yourChoice'),
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'otherChoice'),
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

    List<Widget> interface =
        WidgetsList.backWidgets(widget.variables, context, next);
    // i=27;
    return Scaffold(
        body: Center(
          child: Container(
            height: Resize.getHeight(context),
            width: Resize.getWidth(context),
            child: Stack(
              children: [
                interface[exibitionOrder[i].interfaceIndex],
                instructions[exibitionOrder[i].textIndex],

                // DilemmaGameTutorial(widget.variables,AppLocalizations.of(context).translate('yourChoice'),AppLocalizations.of(context).translate('otherChoice'),)
              ],
            ),
          ),
        ),
        floatingActionButton: exibitionOrder[i].enableNext
            ? FloatingActionButton(
                backgroundColor: Colors
                    .blueAccent, //(indexList[i].enableNext)? Colors.teal:Colors.grey,
                onPressed: next,
                tooltip: AppLocalizations.of(context).translate('next'),
                child: Icon(Icons.arrow_forward),
              )
            : null);
  }
}
