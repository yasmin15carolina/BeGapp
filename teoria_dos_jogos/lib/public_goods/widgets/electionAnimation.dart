import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';

class ElectionAnimation extends StatefulWidget {
  final double value; //screenheight/2
  final double fontSize;
  final onEndAnimation;

  ElectionAnimation(this.value, {required this.fontSize, this.onEndAnimation});
  @override
  _ElectionAnimationState createState() => _ElectionAnimationState();
}

class _ElectionAnimationState extends State<ElectionAnimation> {
  double targetValue = 0;
  late double endPoint;
  late double startPoint;
  int delay = 2;
  @override
  void initState() {
    targetValue = 0;
    endPoint = 0;
    startPoint = widget.value;
    super.initState();
  }

  startAnimation() {
    setState(() {
      targetValue = targetValue == endPoint ? startPoint : endPoint;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    double fontSize = (widget.fontSize != null)
        ? widget.fontSize
        : MediaQuery.of(context).size.height / 10;
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            child: TweenAnimationBuilder(
          tween: Tween<double>(begin: startPoint, end: targetValue),
          duration: Duration(milliseconds: 800),
          onEnd: () {
            Future.delayed(Duration(seconds: delay), () {
              widget.onEndAnimation();
            });
          },
          builder: (BuildContext context, double value, Widget? child) {
            return Container(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, value),
                child: BorderedText(
                    strokeWidth: 5.0,
                    strokeColor: Colors.white,
                    child:
                        Text(AppLocalizations.of(context).translate('election'),
                            style: GoogleFonts.getFont('Ranchers',
                                textStyle: TextStyle(
                                  fontSize: fontSize,
                                  // color: Colors.blueAccent[700],
                                  color: Colors.greenAccent,
                                  decoration: TextDecoration.none,
                                )))),
              ),
              // ))
            );
          },
        )
            // ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //         startAnimation();
            //       },
            //   ),
            ));
  }
}
