import 'package:fl_chart/fl_chart.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/store/dilemmaround_store.dart';

class User {
  var id;
  var name;
  var age;
  var gender;
  var cours;
  var imgPath;
  var educationLevel;
  var occupation;
  var experiment;
  var device;
  DateTime? start;

  List<FlSpot> cooperateList = [];
  List<FlSpot> defectList = [];

  User(
      {this.name,
      this.age,
      this.cours,
      this.gender,
      this.imgPath,
      this.educationLevel,
      this.occupation});

  graphicCooperate(List<DilemmaRound> rounds) {
    cooperateList = [];
    int i = 0, cooperate = 0;
    for (i = 0; i < rounds.length; i++) {
      if (rounds[i].userChoice == 0) {
        cooperate++;
      }
      this
          .cooperateList
          .add(new FlSpot((i + 1).toDouble(), cooperate.toDouble()));
    }
    return this.cooperateList;
  }

  graphicdefect(List<DilemmaRound> rounds) {
    defectList = [];
    int i = 0, defect = 0;
    for (i = 0; i < rounds.length; i++) {
      if (rounds[i].userChoice == 1) {
        defect++;
      }
      this.defectList.add(new FlSpot((i + 1).toDouble(), defect.toDouble()));
    }
    return this.defectList;
  }
}
