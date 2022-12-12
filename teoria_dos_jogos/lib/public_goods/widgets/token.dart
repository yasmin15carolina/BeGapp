import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class GameToken extends StatefulWidget {
  final int value;
  final bool isDraggable;
  final int round;
  final int maxValue;
  final List<int> list;

  GameToken(
      {required this.value,
      required this.maxValue,
      required this.isDraggable,
      required this.round,
      required this.list});
  @override
  _GameTokenState createState() => _GameTokenState();
  colors() {
    Color tokenColor;
    // Random random = new Random();
    // int a = 156+random.nextInt(100);
    List<Color> colorList = [
      Colors.black,
      Colors.green,
      Colors.amber,
      Colors.teal,
      Color.fromARGB(255, 204, 88, 242),
      Colors.deepOrange,
      Colors.deepPurpleAccent,
      Color.fromARGB(255, 250, 30, 130),
      Color.fromARGB(255, 6, 205, 151),
      Color.fromARGB(255, 13, 71, 161),
      Color.fromARGB(255, 72, 228, 255),
      Color.fromARGB(255, 156, 230, 6),
      Color.fromARGB(255, 248, 107, 199),
      Color.fromARGB(255, 220, 220, 0),
      Color.fromARGB(255, 34, 150, 255)
    ];
    //if(colorList.length>value)
    tokenColor = colorList[list.indexOf(value)];
    // else{
    //     int r = random.nextInt(256);
    //     int g = random.nextInt(256);
    //     int b = random.nextInt(256);
    //     tokenColor = Color.fromARGB(255, r, g, b);
    //     // print("$value Color.fromARGB(255,$r,$g,$b);");
    //     // print("red:{$r}, green:{$g}, blue:{$b},");
    // }
    if (value == maxValue) tokenColor = Colors.redAccent[700]!;
    //switch (value) {
    //   case 0 :
    //     tokenColor=Colors.black;
    //     break;
    //   case 1 :
    //     tokenColor=Colors.green;
    //     break;
    //   case 2 :
    //     tokenColor=Colors.amber;
    //     break;
    //   case 3 :
    //     tokenColor=Colors.teal;
    //     break;
    //   case 4 :
    //     tokenColor=Color.fromARGB(255,204,88,242);//Colors.pink;
    //     break;
    //   case 5 :
    //     tokenColor=Colors.deepOrange;
    //     break;
    //   case 6 :
    //     tokenColor=Colors.deepPurpleAccent;
    //     break;
    //   case 7 :
    //     tokenColor=Color.fromARGB(255,250,30,130);//Colors.blueAccent;
    //     break;
    //   case 8 :
    //     tokenColor=Color.fromARGB(255,6,205,151);//Colors.purple[900];
    //     break;
    //   case 9 :
    //     tokenColor=Colors.blue[900] ;
    //     break;
    //   case 10 :
    //     tokenColor=Colors.redAccent[700];
    //     break;
    //   default:
    //     {
    //       int r = random.nextInt(256);
    //       int g = random.nextInt(256);
    //       int b = random.nextInt(256);
    //       tokenColor = Color.fromARGB(255, r, g, b);
    //       print("$value Color.fromARGB(255,$r,$g,$b);");
    //       print("red:{$r}, green:{$g}, blue:{$b},");
    //     }
    // }
    if (isDraggable)
      return tokenColor;
    else
      return tokenColor = Colors.grey;
  }
}

class _GameTokenState extends State<GameToken> {
  @override
  Widget build(BuildContext context) {
    Color tokenColor = widget.colors();

    double screenHeight = Resize.getHeight(context);
    //print(screenHeight);
    return Draggable<int>(
      onDragStarted: () {
        //  print(widget.round.toString()+"  start  ");
      },
      //  onDragEnd: (DraggableDetails  details) => print(widget.round.toString()+"  end  "),
      // onDragCompleted: () => print("complete"),
      // onDraggableCanceled: (velocity, offset) => print("canceled"),
      maxSimultaneousDrags: widget.isDraggable ? null : 0,
      data: widget.value,
      child: Container(
        height: 0.12 * screenHeight,
        width: 0.14 * screenHeight,
        decoration: BoxDecoration(
          //color: widget.isDraggable ? Colors.blue[900] :Colors.indigo[300],
          color: tokenColor,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
            child: Text(
          widget.value.toString(),
          style: TextStyle(color: Colors.white, fontSize: 0.04 * screenHeight),
        )),
      ),
      childWhenDragging: SizedBox(
        height: 50,
        width: 100,
      ),
      feedback: // widget.isDraggable ?
          Container(
        height: 0.12 * screenHeight,
        width: 0.14 * screenHeight,
        decoration: BoxDecoration(
          //color: widget.isDraggable ? Colors.blue[900] :Colors.indigo[300],
          color: tokenColor,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
            child: Text(
          widget.value.toString(),
          style: TextStyle(color: Colors.white, fontSize: 0.04 * screenHeight),
        )),
      ),
      //:SizedBox(height: 0.12*screenHeight,
      //width: 0.14*screenHeight,),
    );
  }
}
