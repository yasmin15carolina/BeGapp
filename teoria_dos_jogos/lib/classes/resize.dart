import 'package:flutter/material.dart';

class Resize {
  static getHeight(context) {
    // return MediaQuery.of(context).size.height * 0.5 * getRatio(context);
    if (getRatio(context) < 1)
      return MediaQuery.of(context).size.height * 0.5;
    else if (getRatio(context) < 1.4)
      return MediaQuery.of(context).size.height * 0.75;
    // else if (getRatio(context) < 1.8)
    //   return MediaQuery.of(context).size.height * 0.85;
    return MediaQuery.of(context).size.height;
  }

  static getWidth(context) {
    if (getRatio(context) > 2.1) return getHeight(context) * 2;
    return MediaQuery.of(context).size.width;
  }

  static getRatio(context) {
    // print(MediaQuery.of(context).size.aspectRatio);
    // print(getRatio(context));
    return MediaQuery.of(context).size.aspectRatio;
  }
}
