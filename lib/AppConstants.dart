import 'package:flutter/material.dart';

class AppConstants {

  static final Map<int, Color> mainColors = {
    50: Color.fromRGBO(51, 204, 0, .1),
    100: Color.fromRGBO(51, 204, 0, .2),
    200: Color.fromRGBO(51, 204, 0, .3),
    300: Color.fromRGBO(51, 204, 0, .4),
    400: Color.fromRGBO(51, 204, 0, .5),
    500: Color(basicColor),
    600: Color.fromRGBO(51, 204, 0, .7),
    700: Color.fromRGBO(51, 204, 0, .8),
    800: Color.fromRGBO(51, 204, 0, .9),
    900: Color.fromRGBO(51, 204, 0, 1),
  };

  static final int basicColor = 0xFF33cc00;

  static final mainColor = MaterialColor(basicColor, mainColors);
  static final greyColor = Color(0xFFF6F6F6);

  static Uri mailtoURI = Uri(
    scheme: 'mailto',
    path: 'flocksserver@gmail.com',
    query: 'subject=Feedback',
  );

}