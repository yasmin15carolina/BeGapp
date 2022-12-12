import 'dart:io';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';

class Connection {
  static checkConnection(context) async {
    // await Future.delayed(
    //   Duration(
    //     seconds: 2,
    //   ),
    // );
    // return true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        // Navigator.pop(context);
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      // Navigator.pop(context);
      // noConnection(context);
      return false;
    }
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     print('connected');
    //     // Navigator.pop(context);
    //     return true;
    //   }
    // } on SocketException catch (_) {
    //   print('not connected');
    //   // Navigator.pop(context);
    //   // noConnection(context);
    //   return false;
    // }
  }

  static loading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  // backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        // SizedBox(height: 10,),
                        // Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }

  static loadingConnection(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  // backgroundColor: Colors.black54,
                  children: <Widget>[
                    FutureBuilder(
                      future: checkConnection(context),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: AlertDialog(
                            content: Text(
                              AppLocalizations.of(context)
                                  .translate('invalidCode'),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 30),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('ok'),
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                30),
                                  )),
                            ],
                          ));
                        }
                        Navigator.of(context).pop();
                        return Center();
                      },
                    ),
                  ]));
        });
  }

  static noConnection(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.signal_cellular_connected_no_internet_4_bar),
                      Text(
                        AppLocalizations.of(context).translate('noConnection'),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30),
                      ),
                    ]),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('ok'),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 25),
                      )),
                ],
              ));
        });
  }

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(key: key,
                  // backgroundColor: Colors.black,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        // SizedBox(height: 10,),
                        // Text("Please Wait...",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}
