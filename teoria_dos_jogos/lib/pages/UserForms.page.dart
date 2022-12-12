import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/Database.dart';
import 'package:teoria_dos_jogos/classes/maxLength.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/pages/tutorial.page.dart';
import 'package:teoria_dos_jogos/public_goods/pages/PublicGoodsTutorial.page.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:teoria_dos_jogos/DropDownField.dart';

// ignore: must_be_immutable
class UserForms extends StatefulWidget {
  final game;
  var variables;
  List<MaxLength>? lengths;
  UserForms(
    this.game, {
    this.variables,
    this.lengths,
  });
  @override
  _UserFormsState createState() => _UserFormsState();
}

class _UserFormsState extends State<UserForms> {
  String dropImageValue = "assets/FemaleR.png";
  User user = new User(cours: '', imgPath: "assets/FemaleR.png");
  var txtName = TextEditingController();
  var txtAge = new TextEditingController();
  var txtCurs = new TextEditingController();
  var txtOccupation = new TextEditingController();
  var other = true;
  var female = false;
  var male = false;
  bool superior = false;
  bool otherCurs = false;
  late List<String> levels;
  late List<String> courses;
  String dropdownEducation = '';
  String dropdownCurs = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool nickAvailable = true;

  @override
  void initState() {
    user.start = DateTime.now();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  String? validator(value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate('Required field');
    }
    return null;
    // return "";
  }

  String? validatorNickname(value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate('Required field');
    }
    if (!nickAvailable) return "Nome indisponível";
    return null; //AppLocalizations.of(context).translate('Required field');
    // return "";
  }

  @override
  Widget build(BuildContext context) {
    double longestSide = MediaQuery.of(context).size.longestSide;
    bool landscape = MediaQuery.of(context).size.aspectRatio > 1.5;
    // longestSide == screenWidth;
    double labelSize = landscape ? longestSide * 0.015 : longestSide * 0.03;
    double fontSize = labelSize;
    double padding = landscape ? longestSide * 0.02 : longestSide * 0.03;
    double paddingCheckbox =
        landscape ? longestSide * 0.02 : longestSide * 0.05;
    double dropdownPadding = // 0;
        landscape ? longestSide * 0.016 : longestSide * 0.035;
    setDecoration(String label) {
      return InputDecoration(
          counterText: "",
          labelText: label,
          labelStyle: TextStyle(fontSize: labelSize),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ));
    }

    levels =
        AppLocalizations.of(context).translate('educationLevels').split(',');
    courses = AppLocalizations.of(context).translate('courses').split(',');
    if (dropdownCurs == '' && dropdownEducation == '') {
      dropdownEducation = levels.first;
      dropdownCurs = courses.first;
      user.educationLevel = dropdownEducation;
    }
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        isAlwaysShown: true,
        child: ListView(children: [
          Form(
            key: _formKey,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextFormField(
                    validator: validatorNickname,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(
                          widget.lengths![0].CHARACTER_MAXIMUM_LENGTH),
                    ],
                    controller: txtName,
                    onChanged: (value) async {
                      nickAvailable = true;
                      String r = await Database.select(
                          "SELECT * FROM users WHERE `name`='" + value + "'");
                      List jsonList = jsonDecode(r)['table_data'] as List;
                      nickAvailable = jsonList.length == 0;
                      _formKey.currentState!.validate();
                    },
                    decoration: setDecoration(
                        AppLocalizations.of(context).translate('nickname')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: padding, right: padding, bottom: padding),
                  child: TextFormField(
                    controller: txtAge,
                    decoration: setDecoration(
                        AppLocalizations.of(context).translate('age')),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('Required field');
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: paddingCheckbox),
                        child: Text(
                          AppLocalizations.of(context).translate('gender'),
                          style: TextStyle(fontSize: labelSize),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      )
                    ]),
                Padding(
                  padding: EdgeInsets.only(left: paddingCheckbox),
                  child: new Row(children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (bool? b) {
                        setState(() {
                          if ((other || male) && b!) {
                            other = false;
                            male = false;
                            female = true;
                          } else {
                            female = false;
                            other = true;
                          }
                        });
                      },
                      value: female,
                    ),
                    Text(AppLocalizations.of(context).translate('female'),
                        style: TextStyle(fontSize: fontSize),
                        textAlign: TextAlign.center),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: paddingCheckbox),
                  child: new Row(children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (bool? b) {
                        setState(() {
                          if ((female || other) && b!) {
                            female = false;
                            male = true;
                            other = false;
                          } else {
                            male = false;
                            other = true;
                          }
                        });
                      },
                      value: male,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('male'),
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: paddingCheckbox),
                  child: new Row(children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (bool? b) {
                        setState(() {
                          if ((female || male) && b!) {
                            female = false;
                            male = false;
                            other = true;
                          } else {
                            other = false;
                            female = true;
                          }
                        });
                      },
                      value: other,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('other'),
                      style: TextStyle(fontSize: fontSize),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextFormField(
                    controller: txtOccupation,
                    decoration: setDecoration(
                        AppLocalizations.of(context).translate('occupation')),
                    validator: validator,
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(
                          widget.lengths![1].CHARACTER_MAXIMUM_LENGTH),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dropdownPadding),
                  child: DropDownField(
                    labelText: AppLocalizations.of(context)
                        .translate('educationLevel'),
                    items: levels,
                    value: dropdownEducation,
                    onChanged: (String? newValue) {
                      setState(() {
                        user.educationLevel = newValue!;
                        dropdownEducation = newValue;
                        (newValue == levels[levels.length - 2] ||
                                newValue == levels.last)
                            ? superior = true
                            // ignore: unnecessary_statements
                            : {superior = false, otherCurs = false};
                      });
                    },
                  ),
                ),
                superior
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: dropdownPadding, vertical: 10),
                        child: DropDownField(
                          labelText:
                              AppLocalizations.of(context).translate('cours'),
                          items: courses,
                          value: dropdownCurs,
                          onChanged: (String? newValue) {
                            setState(() {
                              user.cours = newValue!;
                              dropdownCurs = newValue;
                              (newValue == courses.last)
                                  ? otherCurs = true
                                  : otherCurs = false;
                            });
                          },
                        ),
                      )
                    : Divider(color: Colors.white, height: 0.0),
                otherCurs
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding,
                        ),
                        child: TextFormField(
                          controller: txtCurs,
                          decoration: setDecoration(AppLocalizations.of(context)
                              .translate('coursName')),
                          validator: validator,
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                          },
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(
                                widget.lengths![2].CHARACTER_MAXIMUM_LENGTH),
                          ],
                        ),
                      )
                    : Divider(color: Colors.white, height: 0.0),
                Container(
                  // height: double.infinity,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding),
                  padding: EdgeInsets.symmetric(vertical: padding / 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PublicGoodsTutorialPage(
                      //             null, widget.variables)));
                      if (_formKey.currentState!.validate()) {
                        user.name = txtName.text;
                        (txtAge.text == "")
                            ? user.age = '0'
                            : user.age = txtAge.text;
                        user.occupation = txtOccupation.text;
                        if (male)
                          user.gender = "Masculino";
                        else if (female)
                          user.gender = "Feminino";
                        else
                          user.gender = "Outro";
                        if (user.cours == "Outro") user.cours = txtCurs.text;
                        if (widget.variables == null)
                          user.experiment = "";
                        else
                          user.experiment = widget.variables.key;
                        if (UniversalPlatform.isAndroid) {
                          AndroidDeviceInfo androidInfo =
                              await deviceInfo.androidInfo;
                          user.device =
                              "${androidInfo.brand} ${androidInfo.model} ${androidInfo.version.release}";
                        } else if (UniversalPlatform.isIOS) {
                          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                          user.device = " ${iosInfo.model}";
                        } else if (UniversalPlatform.isWeb) {
                          user.device = "web browser";
                        }
                        //armazenando usuario no banco
                        user.id = await Database.insertUser(user);
                        print("USER GET ID{${user.id}}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    (widget.game == "PrisonerDilemma")
                                        ? DilemmaTutorialPage(
                                            user, widget.variables)
                                        : PublicGoodsTutorialPage(
                                            user, widget.variables)));
                      }
                    },
                    child: Text(AppLocalizations.of(context).translate('next'),
                        style:
                            TextStyle(fontSize: fontSize, color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
