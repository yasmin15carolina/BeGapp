// import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';
import 'package:teoria_dos_jogos/widgets/timer.dart';

import 'package:teoria_dos_jogos/widgets/clock.dart';

class ElectionPopUp extends StatefulWidget {
  final int pId;
  final int players;
  final int time;
  final Function computeVote;
  final Function nextRound;
  final bool tutorial;
  final Function? electionTime;

  ElectionPopUp(
      this.pId, this.players, this.time, this.computeVote, this.nextRound,
      {this.tutorial: false, this.electionTime});
  @override
  _ElectionPopUpState createState() => _ElectionPopUpState();
}

class _ElectionPopUpState extends State<ElectionPopUp> {
  List<Vote> listCandidates = [];
  String animation = "Pulse";
  bool timing = true;
  int index = -1;
  late DateTime start;
  @override
  void initState() {
    listCandidates.add(new Vote(widget.pId, false)); //O próprio participante
    for (var i = 1; i < widget.players + 1; i++) {
      listCandidates.add(new Vote((i < widget.pId) ? i : i + 1, false));
    }
    start = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.electionTime != null) {
      Duration d = DateTime.now().difference(start);
      if (d.inSeconds > widget.time) d = Duration(seconds: widget.time);
      widget.electionTime!(DateTime.now().difference(start));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    double fontSize = screenHeight / 20;
    return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                AppLocalizations.of(context).translate('chooseVote'),
                style: TextStyle(
                    fontSize: fontSize * 1.4, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: Container(
                    margin: EdgeInsets.only(
                        right: screenWidth / 2.5,
                        top: screenHeight / 6,
                        bottom: screenHeight / 10),
                    child: GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        children: listCandidates
                            .map((e) => GridTile(
                                    child: Container(
                                  // color: Colors.red.withOpacity(0.4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Checkbox(
                                            shape: CircleBorder(),
                                            value: e.vote,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize.padded,
                                            onChanged: (bool? x) {
                                              setState(() {
                                                listCandidates
                                                    .forEach((element) {
                                                  element.vote = false;
                                                });
                                                e.vote = !e.vote;
                                                index = e.id;
                                              });
                                            }),
                                      ),
                                      (e.id != widget.pId)
                                          ? Text(
                                              "P" + e.id.toString(),
                                              style:
                                                  TextStyle(fontSize: fontSize),
                                            )
                                          : Text(
                                              AppLocalizations.of(context)
                                                  .translate('you'),
                                              style:
                                                  TextStyle(fontSize: fontSize),
                                            )
                                    ],
                                  ),
                                )))
                            .toList()))),
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: screenWidth / 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          Clock(animation: animation),
                          TimerCount(
                            time: widget.time,
                            animationEnds: () {
                              setState(() {
                                if (!widget.tutorial) {
                                  animation = "Shake";
                                  SoundEffects.play('audio/ClockBell.mp3');
                                }
                                timing = false;
                                if (!widget.tutorial)
                                  Future.delayed(
                                      new Duration(
                                          seconds: 1,
                                          milliseconds: 50), () async {
                                    animation = "Stop";
                                    Navigator.pop(context);
                                    widget.computeVote(
                                        -1, widget.players, widget.nextRound);
                                    // widget.distribute(userEarning.toInt(),widget.players);
                                    // Navigator.of(context).pop();
                                  });
                              });
                            },
                            start: timing,
                          ),
                        ],
                      ),
                      Opacity(
                          opacity: (index > -1) ? 1 : 0.5,
                          child: Container(
                              margin: EdgeInsets.all(
                                  Resize.getHeight(context) * 0.02),
                              padding: EdgeInsets.all(
                                  Resize.getHeight(context) * 0.01),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[400],
                                borderRadius: BorderRadius.circular(
                                    Resize.getHeight(context) * 0.01),
                              ),
                              child: TextButton(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('confirm'),
                                  style: TextStyle(fontSize: fontSize * 1.4),
                                ),
                                onPressed: () {
                                  if (index > -1 &&
                                      !widget.tutorial &&
                                      timing) {
                                    print("ENTROU " + index.toString());
                                    Navigator.pop(context);
                                    widget.computeVote(index, widget.players,
                                        widget.nextRound);
                                    // concludeElection(context,index,widget.players);
                                  }
                                },
                              ))),
                    ]))
          ],
        ));
  }
}

class Vote {
  final int id;
  bool vote;
  Vote(this.id, this.vote);
}

// WillPopScope(
//   onWillPop: () async=>true,
//   child:
//         ListView.builder(
//           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           itemBuilder: (context, index) {
//              return
//              Row(
//                children:[
//                 Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularCheckBox(
//                           value: listCandidates[i1].vote,
//                           materialTapTargetSize: MaterialTapTargetSize.padded,
//                           onChanged: (bool x) {
//                             setState(() {
//                               listCandidates.forEach((element) {element.vote=false;});
//                               listCandidates[i1].vote = !listCandidates[i1].vote;
//                             });
//                           }
//                         ),
//                         (listCandidates[i1].id>0)?
//                         Text("J"+listCandidates[i1].id.toString(),style: TextStyle(fontSize: fontSize),)
//                         :Text("Você",style: TextStyle(fontSize: fontSize),)
//                     ],),
//                 Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularCheckBox(
//                           value: listCandidates[i1].vote,
//                           materialTapTargetSize: MaterialTapTargetSize.padded,
//                           onChanged: (bool x) {
//                             setState(() {
//                               listCandidates.forEach((element) {element.vote=false;});
//                               listCandidates[i1].vote = !listCandidates[i1].vote;
//                             });
//                           }
//                         ),
//                         (listCandidates[i1].id>0)?
//                         Text("J"+listCandidates[i1].id.toString(),style: TextStyle(fontSize: fontSize),)
//                         :Text("Você",style: TextStyle(fontSize: fontSize),)
//                     ],),
//                 Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularCheckBox(
//                           value: listCandidates[i1].vote,
//                           materialTapTargetSize: MaterialTapTargetSize.padded,
//                           onChanged: (bool x) {
//                             setState(() {
//                               listCandidates.forEach((element) {element.vote=false;});
//                               listCandidates[i1].vote = !listCandidates[i1].vote;
//                             });
//                           }
//                         ),
//                         (listCandidates[i1].id>0)?
//                         Text("J"+listCandidates[i1].id.toString(),style: TextStyle(fontSize: fontSize),)
//                         :Text("Você",style: TextStyle(fontSize: fontSize),)
//                     ],),
//                ]
//              );

//           },

//         )

// );
