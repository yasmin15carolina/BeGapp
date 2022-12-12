import 'package:flutter/material.dart';

import 'dilemmaCard.dart';

// ignore: must_be_immutable
class DraggableCard extends StatelessWidget {
  Color color;
  bool draggable;
  DraggableCard(this.color, this.draggable);
  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: color == Colors.red ? 0 : 1,
      maxSimultaneousDrags: draggable ? null : 0,
      childWhenDragging: DilemmaCard(),
      child: draggable ? DilemmaCard(color: color) : DilemmaCard(),
      feedback: DilemmaCard(color: color),
    );
  }
}
