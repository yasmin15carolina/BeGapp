import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class InstructionRect extends StatelessWidget {
  final String instructiontxt;
  final Alignment alignment;

  InstructionRect(this.instructiontxt, {required this.alignment});
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    double fontsize = screenHeight / 25;

    return Container(
        // color: Colors.green.withOpacity(0.8),
        //alignment: Alignment.center,
        //alignment: alignment,
        padding: EdgeInsets.only(top: 5),
        child: Column(children: [
          Container(
            width: screenWidth / 1.6,
            //padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.red.withOpacity(0.8),
            ),
            child: Text(
              instructiontxt,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontsize * 1.7,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Stack(children: [
            Center(
              child: Icon(
                Icons.arrow_downward,
                color: Colors.red.withOpacity(0.7),
                size: fontsize * 4,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.065, left: screenWidth * 0.15),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red.withOpacity(0.7),
                  size: fontsize * 4,
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.35, left: screenWidth * 0.15),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red.withOpacity(0.7),
                  size: fontsize * 4,
                )),
            CustomPaint(
              painter: PainterLines(
                  screenHeight * 0.003, screenWidth * 0.25, fontsize / 2),
              child: Container(
                  //color: Colors.pinkAccent,
                  ),
            ),
          ]),
        ]));
  }
}

//draw arrow
class PainterLines extends CustomPainter {
  double top;
  double left;
  double stroke;
  PainterLines(this.top, this.left, this.stroke);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = Colors.red.withOpacity(0.7);
    double y1 = 48 * top;
    double y2 = 3 * y1;
    canvas.drawLine(Offset(left, 0), Offset(left, y2), paint);
    canvas.drawLine(
        Offset(left + stroke / 2, y1), Offset(left / 1.4, y1), paint);
    canvas.drawLine(
        Offset(left + stroke / 2, y2), Offset(left / 1.4, y2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
