import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:teoria_dos_jogos/main.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    portraitModeOnly();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.delayed(Duration(seconds: 3), () async {
      // Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          pageBuilder: (context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              // Container()
              ChooseGamePage(
            title: "",
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        "assets/images/logo.png",
        scale: 2,
      ),
    );
  }
}
