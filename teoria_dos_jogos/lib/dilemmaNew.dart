// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:teoria_dos_jogos/animatedCard.dart';
// import 'package:teoria_dos_jogos/classes/rotation.dart';
// import 'package:teoria_dos_jogos/dilemmaCard.dart';
// import 'package:teoria_dos_jogos/draggableCard.dart';
// import 'package:teoria_dos_jogos/resultsMatrix.dart';

// import 'animatedResult2.dart';

// class DilemmaNew extends StatefulWidget {
//   @override
//   _DilemmaNewState createState() => _DilemmaNewState();
// }

// class _DilemmaNewState extends State<DilemmaNew> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     landscapeModeOnly();
//     SystemChrome.setEnabledSystemUIOverlays([]);
//   }

//   Widget yourChoice = DilemmaCard(borderColor: Colors.black,);
//   Widget otherChoice = DilemmaCard(borderColor: Colors.black,);
//   int userChoice = -1;
//   bool draggable = true;


//    onEndCardAnimation(Color color){
//     setState(() {
//       otherChoice = DilemmaCard(color: color,);
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     double p =0.4;
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       // backgroundColor: Colors.blueGrey[200],
//       body: Stack(
//         children:[
//           Container(
//             padding: EdgeInsets.only(left: width*0.01),
//             child: Flex(
//               direction: Axis.horizontal,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//               Expanded(
//                 flex: 2,
//                 child: 
//                 Opacity(opacity: 1,child: 
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children:[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                         Column(
//                           children: [
//                           Text("Sua escolha"),
//                           DragTarget<int>(
//                             onAccept: (value){
//                               Color _color = value==0? Colors.red:Colors.black;
//                               yourChoice = DilemmaCard(color: _color,);
//                               setState(() {
//                                 draggable=false;
//                                 userChoice=value;
//                               });
//                               Future.delayed(Duration(seconds: 3),
//                               (){
//                                 setState(() {
//                                   draggable=true;
//                                   userChoice=-1;
//                                   yourChoice = DilemmaCard(borderColor: Colors.black,);
//                                 });

//                               }
//                               );
                                
//                             },
//                             builder: (context, candidates, rejects){
//                             return yourChoice;
//                             }
//                           )
//                         ],),
//                         Column(
//                           children: [
//                             Text("Escolha do outro(a)"),
//                             otherChoice,
//                         ],),
//                       ],),
//                       Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Expanded(
//                             child:Flex(
//                               direction: Axis.horizontal,
//                               children: [
//                               Expanded(
//                                 child:Column(
//                                   children:[
//                                     Container(
//                                       padding:EdgeInsets.all(width*0.01),
//                                       decoration: BoxDecoration(
//                                         //color: Colors.blueAccent,
//                                         borderRadius: BorderRadius.circular(5),
//                                         border: Border.all(color: Colors.blueAccent,width: 2),
//                                       ),
//                                       child:Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
                                          
//                                             (userChoice==0 || userChoice==-1)?DraggableCard(Colors.red,draggable):DilemmaCard(color:Colors.red),
//                                             (userChoice==1 || userChoice==-1)?DraggableCard(Colors.black,draggable):DilemmaCard(color:Colors.black),
//                                         ],),
//                                     ),
//                                     Text("suas cartas"),
//                                   ]
//                                 ),
//                               ),
//                               SizedBox(width: width*0.01,),
//                               Expanded(
//                                 child:
//                               Column(
//                                 children:[
//                                   Container(
//                                     padding:EdgeInsets.all(width*0.01),
//                                     decoration: BoxDecoration(
//                                       //color: Colors.blueAccent,
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(color: Colors.blueAccent,width: 2),
//                                     ),
//                                     child:Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                           DilemmaCard(color:Colors.red),
//                                           DilemmaCard(color:Colors.black),
//                                           // AnimatedCard(Colors.red,()=>onEndCardAnimation(Colors.red),Offset(width*0.022,-height*0.455)),
//                                           // AnimatedCard(Colors.black,()=>onEndCardAnimation(Colors.black),Offset(-width*0.115,-height*0.455)),
//                                       ],),
//                                   ),
//                                   Text("Cartas do outro(a)"),
//                                 ]
//                               )
//                               )
//                               ],)
//                           ),
                        
//                       ],),
//                     ]
//                   ),
//               ),
//             ),

//               //MATRIZ DAS POSSIBILIDADES
//               Expanded(
//                 flex: 1,
//                 child: ResultsMatrix(p,"",false)
//               )
//             ],)
//           ),

//           // AnimatedResult(p:p,offset: Offset(width*0.335,-height*0.3),color1: Colors.red,color2: Colors.red,value1: 5,value2: 5,)
//           // AnimatedResult(p:p,offset: Offset(width*0.335,-height*0.08),color1: Colors.black,color2: Colors.black,value1: 2,value2: 2,)
//           // AnimatedResult(p:p,offset: Offset(width*0.335,height*0.15),color1: Colors.black,color2: Colors.red,value1: 6,value2: 1,)
//           // AnimatedResult(p:p,offset: Offset(width*0.335,height*0.375),color1: Colors.red,color2: Colors.black,value1: 1,value2: 6,)
//         ]
//       )
//     );
//   }
// }
// // class Coordenates{
// //   double x;
// //   double
// // }