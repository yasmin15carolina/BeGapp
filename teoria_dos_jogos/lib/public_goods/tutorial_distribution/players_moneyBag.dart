import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

// ignore: must_be_immutable
class PlayersRibRepresentation extends StatefulWidget {
  double value;
  PlayersRibRepresentation(this.value);
  @override
  _PlayersRibRepresentationState createState() =>
      _PlayersRibRepresentationState();
}

class _PlayersRibRepresentationState extends State<PlayersRibRepresentation> {
  List<String> paths = [];
  double targetValue = 0;
  double endPoint = 0;
  double startPoint = 0;
  double scale = 1;
  bool visible = false;

  @override
  void initState() {
    paths = [
      "assets/people/Femaleb.png",
      "assets/people/FemaleR.png",
      "assets/people/FemaleGlasses.png",
      "assets/people/Malew.png",
      "assets/people/MaleMoustache.png",
      "assets/people/Maleb.png"
    ];
    paths.shuffle();
    targetValue = widget.value;
    endPoint = widget.value;
    startPoint = widget.value;
    Future.delayed(Duration(seconds: 3), () async {
      setState(() {
        startPoint = widget.value;
        targetValue = 0;
        scale = 1.5;
        visible = true;
      });
    });
    // targetValue = widget.value;
    super.initState();
  }

  // start(context){
  //   setState(() {
  //     targetValue =1;
  //     endPoint = 1;
  //     startPoint =  widget.value;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
                alignment: Alignment.center,
                height: screenHeight * 0.5,
                child: Image.asset(
                  "assets/images/coinsBag.png",
                  // scale: screenHeight / 90,
                )),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Image.asset(
                paths[0],
                scale: 2000 / screenHeight,
              ),
              Image.asset(
                paths[1],
                scale: 2000 / screenHeight,
              ),
              Image.asset(
                paths[2],
                scale: 2000 / screenHeight,
              ),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Image.asset(
                paths[3],
                scale: 2000 / screenHeight,
              ),
              Image.asset(
                paths[4],
                scale: 2000 / screenHeight,
              ),
              Image.asset(
                paths[5],
                scale: 2000 / screenHeight,
              ),
            ]),
          ]),
          if (visible)
            Container(
                child: TweenAnimationBuilder(
              tween: Tween<double>(begin: startPoint, end: targetValue),
              duration: Duration(seconds: 1),
              // onEnd: (){
              //   Future.delayed(Duration(seconds: delay),
              //         (){
              //           widget.onEndAnimation();
              //   });
              //   },
              builder: (BuildContext context, double value, Widget? child) {
                return Container(
                  alignment: Alignment.center,
                  child: Transform.translate(
                      offset: Offset(value, 0),
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 1, end: scale),
                        duration: Duration(seconds: 1),
                        builder: (BuildContext context, double value2,
                            Widget? child2) {
                          return Container(
                            child: Transform.scale(
                              scale: value2,
                              child: Image.asset(
                                paths[1],
                                scale: 2000 / screenHeight,
                              ),
                            ),
                          );
                        },
                      )),
                );
              },
            ))
        ],
      ),
    );
  }
}
