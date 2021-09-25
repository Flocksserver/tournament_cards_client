import 'package:flutter/material.dart';

class AppConstants {

  static final Map<int, Color> einKlangColors = {
    50: Color.fromRGBO(95, 255, 181, .1),
    100: Color.fromRGBO(95, 255, 181, .2),
    200: Color.fromRGBO(95, 255, 181, .3),
    300: Color.fromRGBO(95, 255, 181, .4),
    400: Color.fromRGBO(95, 255, 181, .5),
    500: Color(einKlangBasicColor),
    600: Color.fromRGBO(95, 255, 181, .7),
    700: Color.fromRGBO(95, 255, 181, .8),
    800: Color.fromRGBO(95, 255, 181, .9),
    900: Color.fromRGBO(95, 255, 181, 1),
  };

  static final int einKlangBasicColor = 0xFF5FFFB5;

  static final einKlangColor = MaterialColor(einKlangBasicColor, einKlangColors);
  static final einKlangGreyColor = Color(0xFFF6F6F6);

  static Uri mailtoURI = Uri(
    scheme: 'mailto',
    path: 'flocksserver@gmail.com',
    query: 'subject=Feedback',
  );

}