import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
//import 'dart:math' as math;

// ignore: must_be_immutable
class Count extends StatefulWidget {
  final Function animationEnds;
  final bool down;
  final bool start;
  final int inicial;
  final int diference;
  final int factor;
  double? fontsize;
  Count(
      {required this.animationEnds,
      required this.down,
      required this.start,
      required this.inicial,
      required this.diference,
      required this.factor,
      this.fontsize});

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: widget.diference * mult ~/ factor),
    );
  }

  int get factor {
    int n = (widget.diference ~/ 20);
    if (n == 0) n = 1;
    return n;
  }

  int get mult {
    int nCaracteres;

    nCaracteres = ((widget.inicial - widget.diference).toString().length +
            (widget.diference + widget.inicial).toString().length) ~/
        2;
    if (nCaracteres >= 3) nCaracteres = (widget.diference).toString().length;

    ///(widget.diference + widget.inicial).toString().length;
    nCaracteres = 1; //=(widget.diference).toString().length;
    int n = 1000000;
    for (var i = 0; i < nCaracteres; i++) {
      if (n > 1) {
        n ~/= 10;
      }
    }
    return n;
  }

  String get timerString {
    Duration duration;
    //SUB
    if (widget.down)
      duration = controller.duration! * controller.value +
          Duration(
              microseconds:
                  (widget.inicial - widget.diference) * mult ~/ factor);
    // SOMA
    else {
      duration = controller.duration! * controller.value +
          Duration(microseconds: (widget.inicial) * mult ~/ factor);
    } //print("${(duration.inMicroseconds~/mult)*factor}");
    return "${(duration.inMicroseconds ~/ mult) * factor}";
  }
  // return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}:${(duration.inMilliseconds~/100).toString().padLeft(2, '0')}';
  //return "${(((duration.inSeconds % 60)-10)*(-1))}";

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.start && !controller.isAnimating && widget.down)
      controller.reverse(from: 1).whenComplete(() => widget.animationEnds());
    else if (widget.start && !controller.isAnimating && !widget.down)
      controller.forward(from: 0).whenComplete(() => widget.animationEnds());
    double screenHeight = Resize.getHeight(context);

    return Container(
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Text(
              timerString,
              style: TextStyle(
                  fontSize: (widget.fontsize == null)
                      ? screenHeight / 20
                      : widget.fontsize),
            );
          }),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   // TODO: implement build
//   throw UnimplementedError();
// }
