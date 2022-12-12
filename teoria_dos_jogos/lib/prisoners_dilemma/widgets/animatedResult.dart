import 'package:flutter/material.dart';

import 'dilemmaCard.dart';

// ignore: must_be_immutable
class AnimatedResult extends StatefulWidget {
  Offset? offset;
  Color? color1;
  Color? color2;
  int? value1;
  int? value2;
  double? p;

  AnimatedResult(
      {this.offset,
      this.p,
      this.color1,
      this.color2,
      this.value1,
      this.value2});
  @override
  _AnimatedResultState createState() => _AnimatedResultState();
}

class _AnimatedResultState extends State<AnimatedResult>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Tween<Offset> animationLocation;
  late Tween<double> animationScale;

  bool showLabel = false;
  double begin = 1;
  double targetValue = 1.3;
  double end = 1.3;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animationLocation = Tween<Offset>(begin: Offset(0, 0), end: widget.offset);
    animationScale = Tween<double>(begin: begin, end: targetValue);
    controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white70,
        alignment: Alignment.center,
        child: TweenAnimationBuilder(
            onEnd: () {
              setState(() {
                // showLabel=true;

                targetValue = targetValue == end ? begin : end;
              });
            },
            tween: Tween<double>(begin: begin, end: targetValue),
            duration: Duration(seconds: 1),
            builder: (BuildContext context, double scaleValue, Widget? child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Transform.scale(
                      scale: scaleValue,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showLabel) Text("Você"),
                          DilemmaCard(
                            color: widget.color1!,
                            proportion: widget.p!,
                            txt: "${widget.value1}",
                            txtTitle: "Você",
                          ),
                        ],
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.055,
                  ),
                  Transform.scale(
                    scale: scaleValue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showLabel) Text("Outro(a)"),
                        DilemmaCard(
                          color: widget.color2!,
                          proportion: widget.p!,
                          txt: "${widget.value2}",
                          txtTitle: "Outro(a)",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
