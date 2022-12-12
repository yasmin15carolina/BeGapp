import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircleIndex extends StatefulWidget {
  bool current;
  CircleIndex(this.current);
  @override
  _CircleIndexState createState() => _CircleIndexState();
}

class _CircleIndexState extends State<CircleIndex> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Flexible(
        fit: FlexFit.tight,
        child: Container(
          height: height / 15,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              // border: Border.all(width:5),
              color: widget.current ? Colors.teal : Colors.grey),
        ));
  }
}
