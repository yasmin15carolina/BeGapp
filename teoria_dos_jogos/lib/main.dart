import 'dart:convert';

import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:teoria_dos_jogos/AppLanguage.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/connection.dart';
import 'package:teoria_dos_jogos/classes/maxLength.dart';
import 'package:teoria_dos_jogos/pages/UserForms.page.dart';
import 'package:teoria_dos_jogos/pages/pdf.page.dart';
import 'package:teoria_dos_jogos/pages/welcome.page.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
// import 'package:teoria_dos_jogos/public_goods/pages/publicGoodsVariables.dart';

import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:universal_platform/universal_platform.dart';

import 'classes/Database.dart';
import 'package:http/http.dart' as http;

const _filesToWarmup = [
  "assets/flare/Coins.flr",
  "assets/flare/RedButton.flr",
  "assets/flare/BlackButton.flr",
  "assets/flare/Clock.flr",
  "assets/CoinsShort.flr"
];

Future<void> warmupFlare() async {
  for (final filename in _filesToWarmup) {
    final AssetProvider assetProvider =
        AssetFlare(bundle: rootBundle, name: filename);

    await cachedActor(assetProvider);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  FlareCache.doesPrune = false;
  //jsonHelp = await Database.validateKey("pddd6fc");
  // jsonHelp = await Database.validateKey("pg12326");
  // jsonHelp = await Database.validateKey("pg4");
  warmupFlare().then((_) {
    runApp(MyApp(
      appLanguage: appLanguage,
      //  jsonHelp: jsonHelp,
    ));
  });
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  //final List jsonHelp;
  MyApp({
    required this.appLanguage,
    /*required this.jsonHelp*/
  });

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        // appLanguage.changeLanguage(Locale("pt"));
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: model.appLocal,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('pt', 'BR'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          title: "BeGapp",
          home: //Myteste()
              //PublicGoodsCircle(PublicGoodsVariables("",10,10,3,10,0,5,"default","jogo padrão"))
              // PublicGoodsTutorialPage(
              //     null, PublicGoodsVariables.fromJson(jsonHelp[0]))
              //     ChooseGamePage(
              //   title: "",
              //   jsonHelp: jsonHelp,
              // )
              // MessagePage(
              //     message:
              //         "A maioria das pessoa da sua idade contribuiu mais do que voce,voce estar jogando com um palmeirense aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa bbbbbbbbbbbbbbbcc")
              //     PublicGoodsTutorialPage(
              //   new User(),
              //   PublicGoodsVariables.fromJson(jsonHelp[0]),
              // )
              // PublicGoodsGamePage(
              //     new User(),
              //     PublicGoodsVariables.fromJson(jsonHelp[0]),
              //     new PGTimeTutorial(), [])
              // Container()
              // ElectionTutorial(
              //     PublicGoodsVariables.fromJson(jsonHelp[0]), null, null)
              //  ChooseGamePage(),
              //     UserForms(
              //   "PublicGoods",
              //   lengths: [MaxLength(50), MaxLength(50), MaxLength(50)],
              // ),
              WelcomePage(),
          // AudioTest()
          // PdfPage()
          //     DilemmaTutorialPage(
          //   new User(),
          //   DilemmaVariables.fromJson(jsonHelp[0]),
          // )
          // DilemmaGamePage(null, DilemmaVariables.fromJson(jsonHelp[0]),
          //     null, "Sua escolha", "Escolha do outro(a)", []),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class ChooseGamePage extends StatefulWidget {
  List? jsonHelp;
  ChooseGamePage({Key? key, required this.title, this.jsonHelp})
      : super(key: key);
  final String title;

  @override
  _ChooseGamePageState createState() => _ChooseGamePageState();
}

class _ChooseGamePageState extends State<ChooseGamePage> {
  TextEditingController keytxt = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    portraitModeOnly();
    super.initState();
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Connection.showLoadingDialog(context, _keyLoader); //invoking login
      bool con = (!UniversalPlatform.isWeb)
          ? await Connection.checkConnection(context)
          : true;
      await loadCode(context, con);

      // Navigator.pushReplacementNamed(context, "/home");
    } catch (error) {
      print(error);
    }
  }

  validateKey() async {
    var res = await Database.select(
        "SELECT COUNT(1) as n FROM time_taken_tutorial_pg t INNER JOIN users u on u.id=t.user_id WHERE u.experiment='pg2jac'");
    List json = jsonDecode(res)['table_data'] as List;
    //quantos jogaram pg2
    int pg2 = int.parse(json[0]['n']);
    res = await Database.select(
        "SELECT COUNT(1) as n FROM time_taken_tutorial_pg t INNER JOIN users u on u.id=t.user_id WHERE u.experiment='pg4jac'");
    json = jsonDecode(res)['table_data'] as List;
    //quantos jogaram pg4
    int pg4 = int.parse(json[0]['n']);
    // print(json[0]['n']);
    if (pg2 < pg4) {
      return "pg2jac";
    } else
      return "pg4jac";
  }

  Future<Response> getWorldTime() async {
    Response res;
    try {
      res = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/America/Sao_Paulo'),
          headers: {
            "Accept": "application/json",
            // "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
            // "Access-Control-Allow-Origin": "https://worldtimeapi.org/api"
          });
      // print("JSON TIME:${res.body}");
    } catch (e) {
      // print("ERRO dentro:$e");
      res = await getWorldTime();
    }
    return res;
  }

  loadCode(BuildContext context, bool con) async {
    // bool con = await Connection.checkConnection(_keyLoader.currentContext);
    if (!con) {
      await Future.delayed(Duration(
        seconds: 3,
      ));
      Navigator.of(
        _keyLoader.currentContext!,
      ).pop(); //close the dialoge
      Connection.noConnection(context);
    } else {
      List jsonList;
      String key = keytxt.text;
      key = key.toLowerCase();

      if (key == "jac") {
        key = await validateKey();
        jsonList = await Database.validateKey(key);
      } else
        jsonList = await Database.validateKey(keytxt.text);
      key = key.toLowerCase();

      try {
        print("JSON:${jsonList[0]}");
        var variables;
        String game = "";
        if (key.substring(0, 2) == "pg") {
          variables = PublicGoodsVariables.fromJson(jsonList[0]);
          game = "PublicGoods";
        } else {
          //var json = jsonList[0];

          variables = DilemmaVariables.fromJson(jsonList[0]);
          game = "PrisonerDilemma";
          print("game:" + game);
        }
        /* parte do código que bloqueia o experimento de acordo com a data e hora 
        String theUrl =
            "https://worldtimeapi.org/api/timezone/America/Sao_Paulo";
        Map date;
        Response res = await getWorldTime();
        date = jsonDecode(res.body);

        String dateTime = date['datetime'];
        String offset = date['utc_offset'].substring(0, 3);
        //bloqueando so a hora
        DateTime today =
            DateTime.parse(dateTime).add(Duration(hours: int.parse(offset)));

        String startString = DateTime(
                    today.year,
                    today.month,
                    today.day,
                    variables.start.hour,
                    variables.start.minute,
                    variables.start.second)
                .toIso8601String() +
            date['utc_offset'];
        String endString = DateTime(
                    today.year,
                    today.month,
                    today.day,
                    variables.end.hour,
                    variables.end.minute,
                    variables.end.second)
                .toIso8601String() +
            date['utc_offset'];
        DateTime experimentStart =
            DateTime.parse(startString).add(Duration(hours: int.parse(offset)));
        DateTime experimentSEnd =
            DateTime.parse(endString).add(Duration(hours: int.parse(offset)));
        if (experimentStart.isBefore(today) && experimentSEnd.isAfter(today)) {
          // if(variables.start.isBefore(DateTime.now()) && variables.end.isAfter(DateTime.now())){
          */
        List<MaxLength> lengths = [];
        //lengths.add(MaxLength(await Database.getMaxLength('users', 'name')));
        lengths
            .add(MaxLength(await Database.getMaxLength('users', 'occupation')));
        lengths.add(MaxLength(await Database.getMaxLength('users', 'cours')));

        Navigator.of(
          _keyLoader.currentContext!,
        ).pop(); //close the dialoge
        try {
          final response = await http.head(
              Uri.parse('https://v1.begapp.com.br/files/${variables.key}.pdf'));
          if (response.statusCode == 200) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PdfPage(
                          pdfName: variables.key,
                          then: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserForms(
                                          game,
                                          variables: variables,
                                          lengths: lengths,
                                        )));
                          },
                        )));
          } else
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserForms(
                          game,
                          variables: variables,
                          lengths: lengths,
                        )));
        } catch (e) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserForms(
                        game,
                        variables: variables,
                        lengths: lengths,
                      )));
        }

        /*} else {
          Navigator.of(
            _keyLoader.currentContext,
          ).pop(); //close the dialoge

          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(
                      AppLocalizations.of(context).translate('codeNotReady') +
                          experimentStart.hour.toString().padLeft(2, '0') +
                          ":" +
                          experimentStart.minute.toString().padLeft(2, '0') +
                          " " +
                          date['timezone'],
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          AppLocalizations.of(context).translate("ok"),
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 30),
                        ),
                      ),
                    ],
                  ));
        }*/
      } catch (e) {
        print(e);
        Navigator.of(
          _keyLoader.currentContext!,
        ).pop(); //close the dialoge

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Text(
                    AppLocalizations.of(context).translate('invalidCode'),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context).translate('ok'),
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 30),
                        )),
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    //  Navigator.of(context,rootNavigator: true).pop();
    //  Navigator.of(context).pop();
    return Scaffold(
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: ()async{
      //       // validateKey();
      //       List jsonList = await Database.validateKey("pd");

      //       DilemmaVariables variables=DilemmaVariables.fromJson(jsonList[0]);

      //       print(variables);
      //       Navigator.push(context,
      //         MaterialPageRoute(builder: (context) =>
      //                 // DilemmaGamePage(new User(),variables,PDTimeTutorial() ,AppLocalizations.of(context).translate('yourChoice'),AppLocalizations.of(context).translate('otherChoice'))
      //               DilemmaTutorialPage(new User(),variables)
      //               // WelcomePage()
      //         )
      //       );
      //     }
      //   ),
      appBar: AppBar(
        title: Text("BeGapp"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 35),
        child: ListView(
            //shrinkWrap: true,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Form(
                                child: TextFormField(
                          onFieldSubmitted: (value) {
                            _handleSubmit(context);
                          },
                          controller: keytxt,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .translate('inputCode'),
                          ),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(30),
                          ],
                        ))),
                        InkWell(
                          child: Icon(Icons.send),
                          onTap: () => _handleSubmit(context),
                          // () async {
                          //   List jsonHelp;
                          //   jsonHelp = await Database.validateKey("pddd6fc");

                          // }

                          //()=>Connection.noConnection(context)
                          // ()async{
                          //   // Connection.loading(context);
                          //   bool con = await Connection.checkConnection(context);
                          //   // await Connection.loadingConnection(context);
                          //   if(con){
                          //    }
                          //   //String json = await Database.validateKey(keytxt.text);
                          //   //PublicGoodsVariables variables=PublicGoodsVariables.fromJson(jsonDecode(json)[0]);
                          // },
                        )
                      ],
                    ),
                  ),

                  // Image.asset("assets/images/moneyPig.png",scale: 1.5,),
                  // Container(
                  //   margin: EdgeInsets.all(15),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blueGrey[300],
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   child: FlatButton(
                  //     onPressed:(){
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //         builder: (context) =>

                  //         // UserForms("PublicGoods",variables:PublicGoodsVariables("",10,5,3,1,0,5,"default2","jogo 2",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01"),false,10,10,
                  //         // 2,10,20,
                  //         // 1,4,3,2),lengths: [MaxLength(100),MaxLength(100),MaxLength(100)],)
                  //           GamePage(new User(),PublicGoodsVariables("",10,5,3,2,0,5,"default2","jogo 2",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01"),false,10,10,
                  //           2,10,20,
                  //           30,4,3,2),PGTimeTutorial())
                  //           //   PublicGoodsTutorialPage(new User(), PublicGoodsVariables("",10,5,3,30,0,5,"default2","jogo 2",DateTime.parse("2020-01-01"),DateTime.parse("2020-12-01"),false,10,10,
                  //           // 2,10,20,
                  //           // 5,4,3,2))
                  //         )
                  //       );
                  //     },
                  //     child: Text(AppLocalizations.of(context).translate('publicGoods'))
                  //   ),
                  // ),
                  // // Container(//color: Colors.black,
                  //   child:Image.asset("assets/images/userBlueGreen.png",scale: 4,),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.all(15),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blueGrey[300],
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   child: FlatButton(
                  //     onPressed:
                  //     (){
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => DilemmaTutorialPage(new User(), new DilemmaVariables("key", "tft", "tft Game", 5, 2, 1, 6, 300, 10, 10, true, true, true, true, true,new DateTime(2019,),new DateTime(2030)))
                  //         )
                  //       );
                  //     },
                  //     child: Text(AppLocalizations.of(context).translate('dilemma'))
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 20),
                  //   alignment: Alignment.center,
                  //   child: Text("pg4a - 11:00 (America/Sao_Paulo)\npg4b - 16:00 (America/Sao_Paulo)\npg4c - 19:00 (America/Sao_Paulo)",textAlign: TextAlign.center,style: TextStyle(fontSize:MediaQuery.of(context).size.width*0.06),),
                  // ),
                  // GameToken(value: 8, maxValue: 10, isDraggable: true, round: 2, list:l),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            appLanguage.changeLanguage(Locale("en"));
                          });
                        },
                        child: Text('English'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            appLanguage.changeLanguage(Locale("pt"));
                          });
                        },
                        child: Text('Português'),
                      )
                    ],
                  ),
                ],
              ),
            ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     List jsonHelp;
      //     jsonHelp = await Database.validat    eKey("pg4");
      //     PublicGoodsVariables teste =
      //         PublicGoodsVariables.fromJson(jsonHelp[0]);
      //     print(teste.adminId);
      //   },
      // ),
    );
  }
}
