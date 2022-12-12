// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
// import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/excel.dart';
import 'package:teoria_dos_jogos/classes/pdf.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';
// import 'package:teoria_dos_jogos/public_goods/classes/roundData.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/graphicDoubleYAxis.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/welcome.page.dart';

class GraphicPagePG extends StatefulWidget {
  final List<RoundData>? gameRounds;
  final PublicGoodsVariables? variables;

  const GraphicPagePG({this.gameRounds, this.variables});

  @override
  _GraphicPagePGState createState() => _GraphicPagePGState();
}

class _GraphicPagePGState extends State<GraphicPagePG> {
  GlobalKey _globalKey = new GlobalKey();

  bool inside = false;

  late Uint8List imageInMemory;

  late Image img;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      inside = true;
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      print('png done');
      // setState(() {
      //   imageInMemory = pngBytes;
      //   inside = false;
      // });
      return pngBytes;
    } catch (e) {
      print(e);
      return null as Uint8List;
    }
  }

  @override
  void initState() {
    portraitModeOnly();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.initState();
  }

  @override
  void dispose() {
    landscapeModeOnly();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.dispose();
  }

  //PublicGoodsVariables variables= PublicGoodsVariables(maxTrys: 10, maxTokens: 10, factor: 3, notRealPlayers: 5);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth / 25;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: GraphicDoubleY(
// [ FlSpot(1.0,4.0),
//  FlSpot(2.0,1.0),
//  FlSpot(3.0,5.0),
//  FlSpot(4.0,8.0),
//  FlSpot(5.0,null),
//  FlSpot(7.0,7.0),
//  FlSpot(8.0,9.0),
//  FlSpot(9.0,null),
//  FlSpot(10.0,null),
//  ],
                ResultPubliGoods.f1Spots(widget.gameRounds!),
                widget.gameRounds!.map((roundData) {
                  return FlSpot(
                      roundData.id.toDouble(), roundData.wallet.toDouble());
                }).toList(),
                Colors.black,
                Colors.red,
                AppLocalizations.of(context).translate('investment'),
                AppLocalizations.of(context).translate('walletTitle'),
                widget.variables!.maxTokens.toDouble(),
                widget.variables!.maxTrys.toDouble(),
                widget.variables!.maxWalletValue(),
                MediaQuery.of(context).size.width - 20,
                MediaQuery.of(context).size.width / 25,
                MediaQuery.of(context).size.width / 30),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
                child: Row(
                  children: [Text("Pdf  "), Icon(Icons.picture_as_pdf)],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                onPressed: () async {
                  Uint8List bytes = await _capturePng();
                  img = Image.memory(bytes);
                  Pdf().createPdf(bytes);
                }),
            TextButton(
                child: Row(
                  children: [Text("Excel  "), Icon(Icons.save)],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                onPressed: () async {
                  Excelfile file = new Excelfile(context);
                  file.createSheetPublicGoods(
                      widget.gameRounds!, widget.variables!);
                }),
          ]),
          //if(img!=null)Container(child:img)
          Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Clique no link abaixo para responder ao questionário de Feedback.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: fontSize),
                  InkWell(
                      child: new Text(
                        'Formulário de Feedback',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.lightBlue,
                            fontSize: fontSize),
                      ),
                      onTap: () {
                        launch('https://forms.gle/TQczEbJLMJPdqxQa6');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()));
                      })
                ],
              ))
        ],
      )),
    );
  }
}

class ResultPubliGoods {
  static f1Spots(List<RoundData> rounds) {
    List<FlSpot> f1 = rounds.map((roundData) {
      if (roundData.investment == null)
        return FlSpot(roundData.round.toDouble(), null as double);
      else
        return FlSpot(
            roundData.round.toDouble(), roundData.investment.toDouble());
    }).toList();

    for (int i = 1; i < f1.length; i++) {
      while (f1[i].isNull() && f1[i - 1].isNull()) {
        if (f1.last == f1[i]) {
          f1.removeAt(i);
          break;
        }
        f1.removeAt(i);
      }
    }
    // if(f1.last.isNull())f1.removeLast();

    f1.forEach((element) {
      // print("FlSpot("+element.x.toString()+","+element.y.toString()+"),");
    });
    return f1;
  }
}
