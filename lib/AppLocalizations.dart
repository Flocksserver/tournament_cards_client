import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'TT(C) Match Generator',
      'title_step0': 'Single / Double',
      'title_step1': 'Players and Rounds',
      'title_step2': 'Tables',
      'title_step3': 'Sheet',
      'button_next': 'NEXT',
      'button_back': 'BACK',
      'button_gen': 'GENERATE',
      'coming_soon': 'Coming soon - be curious'
    },
    'de': {
      'title': 'TT(C) Match Generator',
      'title_step0': 'Einzel / Doppel',
      'title_step1': 'Spieler und Runden',
      'title_step2': 'Tische',
      'title_step3': 'Zettel',
      'button_next': 'WEITER',
      'button_back': 'ZURÜCK',
      'button_gen': 'GENERIEREN',
      'coming_soon': 'Bald verfügbar - seid gespannt',
    },
  };

  static List<String> languages ()=> _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get titleStep0 {
    return _localizedValues[locale.languageCode]!['title_step0']!;
  }

  String get titleStep1 {
    return _localizedValues[locale.languageCode]!['title_step1']!;
  }

  String get titleStep2 {
    return _localizedValues[locale.languageCode]!['title_step2']!;
  }

  String get titleStep3 {
    return _localizedValues[locale.languageCode]!['title_step3']!;
  }

  String get buttonNext {
    return _localizedValues[locale.languageCode]!['button_next']!;
  }

  String get buttonBack {
    return _localizedValues[locale.languageCode]!['button_back']!;
  }

  String get buttonGen {
    return _localizedValues[locale.languageCode]!['button_gen']!;
  }

  String get comingSoon {
    return _localizedValues[locale.languageCode]!['coming_soon']!;
  }
}