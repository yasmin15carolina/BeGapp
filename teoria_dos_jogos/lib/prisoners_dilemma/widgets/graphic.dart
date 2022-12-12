import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';

class Graphic extends StatefulWidget {
  final List<FlSpot>? cooperate; //red
  final List<FlSpot>? defect; //black

  const Graphic({this.cooperate, this.defect});
  @override
  _GraphicState createState() => new _GraphicState();
}

class _GraphicState extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double subtitleSquad = screenWidth / 30;
    double fontSize = screenWidth / 25;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 36, vertical: screenWidth / 36),
        child: Column(children: [
          Row(
            children: <Widget>[
              Container(
                  width: subtitleSquad,
                  height: subtitleSquad,
                  color: Colors.red),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  AppLocalizations.of(context).translate('cooperate'),
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              Container(
                  width: subtitleSquad,
                  height: subtitleSquad,
                  color: Colors.black),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    AppLocalizations.of(context).translate('defect'),
                    style: TextStyle(fontSize: fontSize),
                  )),
            ],
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  // height: 140,
                  child: LineChart(
                    LineChartData(
                      // maxY: 50,
                      axisTitleData: FlAxisTitleData(
                        leftTitle: AxisTitle(
                            showTitle: true,
                            titleText: AppLocalizations.of(context)
                                .translate('frequency'),
                            textStyle: TextStyle(
                                fontSize: fontSize, color: Colors.black)),
                        bottomTitle: AxisTitle(
                            showTitle: true,
                            titleText:
                                AppLocalizations.of(context).translate('round'),
                            textStyle: TextStyle(
                                fontSize: fontSize, color: Colors.black)),
                      ),

                      borderData: FlBorderData(
                          show: true,
                          border: Border(
                            left: BorderSide(),
                            bottom: BorderSide(),
                          )),
                      lineTouchData: LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots:
                              //   [
                              //     FlSpot(0,1),
                              //     FlSpot(3,2),
                              //     FlSpot(0,1),
                              //     FlSpot(3,2),
                              // ],//
                              widget.defect,
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.black,
                          ],
                          dotData: FlDotData(
                            show: true,
                            //dotColor: Colors.black,
                          ),
                        ),
                        LineChartBarData(
                          spots:
                              // [
                              //     FlSpot(0,1),
                              //     FlSpot(3,2),
                              //     FlSpot(0,6),
                              //     FlSpot(3,8),
                              // ],//
                              widget.cooperate,
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.red,
                          ],
                          dotData: FlDotData(
                            show: true,
                            //dotColor: Colors.red
                          ),
                        ),
                      ],
                      maxY: 10,
                      minY: 0,
                      maxX: 10,
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          showTitles: true,
                          /* textStyle:
                            TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
                        */
                          getTitles: (value) {
                            return value.toInt().toString();
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTitles: (value) {
                            return (value++).toInt().toString();
                            // return '${value + 10}';
                          },
                          //  textStyle:
                          //  TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      gridData: FlGridData(
                        show: false,
                        checkToShowHorizontalLine: (double value) {
                          return value == 1 ||
                              value == 6 ||
                              value == 4 ||
                              value == 5;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
