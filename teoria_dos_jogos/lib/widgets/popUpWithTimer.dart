import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class PopUpWithTimer extends StatefulWidget {
  final String message;
  final Duration? duration;
  final Function? callback;
  PopUpWithTimer(this.message, {this.duration, this.callback});
  @override
  _PopUpWithTimerState createState() => _PopUpWithTimerState();
}

class _PopUpWithTimerState extends State<PopUpWithTimer> {
  @override
  void initState() {
    Future.delayed(
        (widget.duration != null) ? widget.duration! : Duration(seconds: 2),
        () async {
      Navigator.pop(context);
      if (widget.callback != null) widget.callback!();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Container(
            height: Resize.getHeight(context) / 2,
            width: Resize.getWidth(context) / 2,
            alignment: Alignment.center,
            // margin: EdgeInsets.all(10),
            child: Text(
              widget.message,
              style: TextStyle(fontSize: Resize.getHeight(context) / 10),
              textAlign: TextAlign.center,
            )));
  }
}
