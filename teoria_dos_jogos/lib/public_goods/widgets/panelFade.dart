import 'package:flutter/material.dart';

class PanelFade extends StatefulWidget {
  final Widget child;
  final start;
  PanelFade(this.child, this.start);

  @override
  _PanelFadeState createState() => _PanelFadeState();
}

class _PanelFadeState extends State<PanelFade>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  fade() {
    _controller.forward();
    Future.delayed(Duration(milliseconds: 5000), () {
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.start)
      _controller.repeat();
    else
      _controller.forward();
    //fade();
    return
        // Transform.scale(
        //             scale: _scale,
        //             child: widget.child,
        // );
        FadeTransition(opacity: animation, child: widget.child);
    // Container(
    //  // color: Colors.purple.withOpacity(0.2),
    //   alignment: Alignment.center,
    //   padding: EdgeInsets.only(left:screenWidth/8,bottom: screenHeight/4),
    //   child:Row(
    //     children: [
    //       //Icon(Icons.add,color: Colors.red,),
    //       Text("+",style: TextStyle(fontSize: fontsize,fontWeight: FontWeight.bold, color:Colors.black),),
    //       Text(widget.tokens.toString(),style: TextStyle(fontSize: fontsize,fontWeight: FontWeight.bold),)
    //   ],)
    // )
    //);
  }
}
