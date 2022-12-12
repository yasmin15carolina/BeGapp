import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class NextAnimation extends StatefulWidget {
  final double value; //screenWidth/2
  final String message;
  final double? fontSize;
  final onEndAnimation;

  NextAnimation(this.value, this.message,
      {this.fontSize, required this.onEndAnimation});
  @override
  _NextAnimationState createState() => _NextAnimationState();
}

class _NextAnimationState extends State<NextAnimation> {
  double targetValue = 0;
  late double endPoint;
  late double startPoint;
  int delay = 3;
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
    double fontSize = (widget.fontSize != null)
        ? widget.fontSize
        : Resize.getHeight(context) / 10;
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
                offset: Offset(value, 0),
                child: BorderedText(
                    strokeWidth: 5.0,
                    strokeColor: Colors.white,
                    child: Text(widget.message,
                        style: GoogleFonts.getFont('Ranchers',
                            textStyle: TextStyle(
                              fontSize: fontSize,
                              // color: Colors.blueAccent[700],
                              color: Colors.black,
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
