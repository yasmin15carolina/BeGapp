import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';
import 'package:teoria_dos_jogos/widgets/clock.dart';
import 'package:teoria_dos_jogos/widgets/timer.dart';

class MoneyDistribution extends StatefulWidget {
  final int total;
  final int players;
  final int time;
  final Function distribute;
  final bool tutorial;
  final bool btnEnabled;
  final Function? distributionTime;
  MoneyDistribution(this.total, this.players, this.time, this.distribute,
      {this.tutorial: false, this.btnEnabled: true, this.distributionTime});
  @override
  _MoneyDistributionState createState() => _MoneyDistributionState();
}

class _MoneyDistributionState extends State<MoneyDistribution> {
  double userEarning = 0;
  String animation = "Pulse";
  bool timing = true;

  bool handVisible = true;
  late DateTime start;
  @override
  void initState() {
    //userEarning=widget.total/(widget.players+1); distribuição igualitaria
    start = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.distributionTime != null) {
      Duration d = DateTime.now().difference(start);
      if (d.inSeconds > widget.time) d = Duration(seconds: widget.time);
      widget.distributionTime!(d);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fontsize = Resize.getWidth(context) / 20;
    return Container(
      width: Resize.getWidth(context) / 1.2,
      child: Stack(children: [
        Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: <Widget>[
                        Clock(
                          animation: animation,
                          scale: 0.9,
                        ),
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
                                    new Duration(seconds: 1, milliseconds: 50),
                                    () async {
                                  animation = "Stop";
                                  widget.distribute(
                                    -1,
                                    widget.players,
                                  );
                                  Navigator.of(context).pop();
                                });
                            });
                          },
                          start: timing,
                          // getTime: widget.distributionTime//!=null ?widget.distributionTime:null,
                        ),
                      ],
                    ),
                    widget.tutorial
                        ? Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                        .translate('total') +
                                    ": ",
                                style: TextStyle(fontSize: fontsize),
                              ),
                              Image.asset(
                                "assets/images/coinsBag.png",
                                height: Resize.getHeight(context) * 0.4,
                                // scale: Resize.getHeight(context) / 40,
                              )
                            ],
                          )
                        : Text(
                            AppLocalizations.of(context).translate('total') +
                                ": " +
                                widget.total.toString(),
                            style: TextStyle(fontSize: fontsize),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Resize.getWidth(context) / 30),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTickMarkColor: Colors.transparent,
                        inactiveTickMarkColor: Colors.transparent,
                        // valueIndicatorColor: Colors.blue, // This is what you are asking for
                        // disabledActiveTickMarkColor: Colors.transparent,
                        // inactiveTrackColor: Color(0xFF8D8E98), // Custom Gray Color
                        // activeTrackColor: Colors.white,
                        // thumbColor: Colors.red,
                        // overlayColor: Color(0x29EB1555),  // Custom Thumb overlay Color
                        // thumbShape:
                        //     RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        // overlayShape:
                        //     RoundSliderOverlayShape(overlayRadius: 20.0),
                      ),
                      child: Slider(
                        value: userEarning.toInt().toDouble(),
                        onChanged: (newRating) {
                          setState(() {
                            userEarning = newRating;
                            handVisible = false;
                          });
                        },
                        min: 0,
                        max: widget.total.toInt().toDouble(),
                        divisions: widget.total,
                        label: (widget.tutorial)
                            ? userEarning.toInt().toString() + "%"
                            : userEarning.toInt().toString(),
                      ),
                    ),
                  ),
                  //   if(widget.tutorial && handVisible)
                  //   Padding(
                  //     padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/8),
                  //     child:
                  //     Transform.rotate(
                  //     angle: -pi*0.3,
                  //     child:Image.asset("assets/images/fingerPointer.png",scale:MediaQuery.of(context).size.height*0.04,),
                  //     )
                  // )
                ]),
              ),
              Container(
                margin: EdgeInsets.all(Resize.getHeight(context) * 0.02),
                padding: EdgeInsets.all(Resize.getHeight(context) * 0.02),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius:
                      BorderRadius.circular(Resize.getHeight(context) * 0.01),
                ),
                child: TextButton(
                    onPressed: (!widget.btnEnabled)
                        ? null
                        : () {
                            if (widget.tutorial)
                              widget.distribute(context);
                            else if (timing) {
                              widget.distribute(
                                userEarning.toInt(),
                                widget.players,
                              );
                              Navigator.of(context).pop();
                            }
                          },
                    child: Text(
                      AppLocalizations.of(context).translate('confirm'),
                      style: TextStyle(fontSize: fontsize * 0.6),
                    )),
              ),
            ]),
        if (widget.tutorial && handVisible)
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: Resize.getWidth(context) * 0.12,
                top: Resize.getHeight(context) * 0.2),
            child: Transform.rotate(
              angle: -pi * 0.3,
              child: Image.asset(
                "assets/images/fingerPointer.png",
                // scale: Resize.getHeight(context) * 0.04,
                height: Resize.getHeight(context) * 0.2,
              ),
            ),
          ),
      ]),
    );
  }
}
