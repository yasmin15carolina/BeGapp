// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/dilemmaCard.dart';

// ignore: must_be_immutable
class DilemmaResultExample extends StatelessWidget {
  String yourChoice;
  String otherChoice;
  String result;
  Color your;
  Color other;
  DilemmaVariables variables;
  DilemmaResultExample(this.yourChoice, this.otherChoice, this.result,
      this.your, this.other, this.variables);
  late String txt1, txt2;
  @override
  Widget build(BuildContext context) {
    double fontSize = Resize.getHeight(context) * 0.06;
    double height = Resize.getHeight(context);
    if (your == Colors.red && other == Colors.red) {
      txt1 = variables.bothCooperate.toString();
      txt2 = variables.bothCooperate.toString();
    } else if (your == Colors.red && other == Colors.black) {
      txt1 = variables.defectWin.toString();
      txt2 = variables.cooperateLoses.toString();
    } else if (your == Colors.black && other == Colors.red) {
      txt1 = variables.cooperateLoses.toString();
      txt2 = variables.defectWin.toString();
    } else if (your == Colors.black && other == Colors.black) {
      txt1 = variables.bothDefect.toString();
      txt2 = variables.bothDefect.toString();
    }
    int txtlength = txt1.length > txt2.length ? txt1.length : txt2.length;
    double heighttxt = height * txtlength * 0.3;
    return Container(
        // color: Colors.green,
        // margin: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: // DilemmaCard(color: Colors.red,),
            Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //

        // Flex(direction: Axis.vertical, children: [
        //   Expanded(
        //     child: Flex(
        //       direction: Axis.horizontal,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           // height: width,
        //           // width: width,
        //           child: Text(
        //             AppLocalizations.of(context).translate(yourChoice),
        //             style: TextStyle(fontSize: fontSize),
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //         // SizedBox(
        //         //   height: height * 0.05,
        //         // ),
        //         Container(
        //           // width: width,
        //           // height: width,
        //           child: Text(
        //             AppLocalizations.of(context).translate(otherChoice),
        //             style: TextStyle(fontSize: fontSize),
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   Expanded(
        //     child: Container(
        //       color: Colors.green,
        //       // margin: EdgeInsets.only(bottom: height / 12),
        //       child: Row(
        //         // direction: Axis.horizontal,
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           DilemmaCard(color: your, txt: txt1),
        //           // SizedBox(
        //           //   height: height * 0.12,
        //           // ),
        //           DilemmaCard(
        //             color: other,
        //             txt: txt2,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ]),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25,
              bottom: MediaQuery.of(context).size.height * 0.35,
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Spacer(),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      AppLocalizations.of(context).translate(yourChoice),
                      style: TextStyle(fontSize: fontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                    child: Center(child: DilemmaCard(color: your, txt: txt1))),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25,
              bottom: MediaQuery.of(context).size.height * 0.35,
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      AppLocalizations.of(context).translate(otherChoice),
                      style: TextStyle(fontSize: fontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: DilemmaCard(
                      color: other,
                      txt: txt2,
                    ),
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
        ),
        Center(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.blueAccent,
            size: fontSize * 3,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // height: width * 1.3,
                // width: width * 1.5,
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).translate(result),
                  style: TextStyle(fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

//  Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: width,
//                     child:Text(AppLocalizations.of(context).translate(yourChoice),style:TextStyle(fontSize: fontSize),textAlign: TextAlign.center,),
//                   ),
//                   Container(
//                     width: width,
//                     child:Text(AppLocalizations.of(context).translate(otherChoice),style:TextStyle(fontSize: fontSize),textAlign: TextAlign.center,),
//                   ),

//                 ],
//               ),
//               SizedBox(height: 20,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   DilemmaCard(color: your,),
//                   Icon(Icons.add,color: Colors.blueAccent,size: fontSize*3,),
//                   DilemmaCard(color: other,),
//                   Text("=",style:TextStyle(color: Colors.blueAccent,fontSize: fontSize*3)),
//                   Container(
//                     width: width,
//                     child:Text(AppLocalizations.of(context).translate(result),style:TextStyle(fontSize: fontSize),textAlign: TextAlign.center,),
//                   )
//                 ],
//               ),

//           ],),
