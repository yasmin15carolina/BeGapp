import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class MessagePage extends StatefulWidget {
  final String? message;
  final Function? next;

  const MessagePage({this.message, this.next});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          body: Center(
              child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  child: Text(
                    widget.message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenHeight * 0.08),
                  ))),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors
                .teal, //(indexList[i].enableNext)? Colors.teal:Colors.grey,
            onPressed: () {
              Navigator.of(context).pop();
              widget.next!();
            }, //next(context),
            tooltip: AppLocalizations.of(context).translate('next'),
            child: Icon(Icons.arrow_forward),
          ),
        ));
  }
}
