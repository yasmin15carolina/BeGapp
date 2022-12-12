import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
//import 'dart:math' as math;

class TimerCount extends StatefulWidget {
  final Function animationEnds;
  final Function? getTime;
  final bool start;
  final int time;
  TimerCount(
      {required this.animationEnds,
      required this.start,
      required this.time,
      this.getTime});

  @override
  _TimerCountState createState() => _TimerCountState();
}

class _TimerCountState extends State<TimerCount> with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

//(((duration.inSeconds % 60)-10)*(-1))
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.time),
    );
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  getTime() {
    Duration duration = controller.duration! * controller.value;
    duration = new Duration(
        seconds: (controller.duration!.inSeconds - duration.inSeconds));
    if (widget.getTime != null) widget.getTime!(duration);
    // print(duration);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.start && !controller.isAnimating)
      controller.reverse(from: 1).whenComplete(() {
        widget.animationEnds();
        getTime();
      });
    else if (!widget.start && controller.isAnimating) {
      controller.stop(canceled: true);
      getTime();
    }

    double screenHeight = Resize.getHeight(context);

    return Container(
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Text(
              //"Tempo: "+
              timerString,
              style: TextStyle(fontSize: screenHeight / 20),
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
