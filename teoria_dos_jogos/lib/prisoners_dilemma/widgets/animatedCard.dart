import 'package:flutter/material.dart';

import 'dilemmaCard.dart';

// ignore: must_be_immutable
class AnimatedCard extends StatefulWidget {
  Color color;
  Function onEnd;
  Offset offset;
  AnimatedCard(this.color, this.onEnd, this.offset);
  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, 0), end: widget.offset),
      duration: Duration(seconds: 1),
      onEnd: () => widget.onEnd(),
      builder: (BuildContext context, Offset value, Widget? child) {
        return Transform.translate(
            offset: value, child: DilemmaCard(color: widget.color));
      },
    );
  }
}
