import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_cards_website/ui/HomePage.dart';

import 'AppConstants.dart';
import 'AppLocalizations.dart';
import 'AppLocalizationsDelegate.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();

  static _AppState? of(BuildContext context) => context.findAncestorStateOfType<_AppState>();
}

class _AppState extends State<App> {
  late Locale _locale = Locale.fromSubtags(languageCode: 'de');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  Locale? getLocale() {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).title,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('de', ''),
      ],
      title: 'TT(C) Match Generator',
      theme: ThemeData(
        primarySwatch: AppConstants.mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: HomePage(),
    );
  }
}


