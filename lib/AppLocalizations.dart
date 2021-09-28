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
      'welcome_title': 'Welcome!',
      'welcome_subtitle': 'Generate great sheets for your TT tournament',
      'welcome_content': 'On this page you will find a generator, with the help of which you can create route cards or referee sheets for single or double tournaments in 5 steps. The focus is on as much variety as possible in opponents and teammates. The project is currently under construction and it is not impossible that you will find a bug or that there are still improvements to the algorithms. Feel free to write me if you have any feedback.',
      'title_step0': 'Tournament type',
      'step0_description': 'Would you like to play a singles or doubles tournament? Choose an option.',
      'single': 'Single',
      'double': 'Double',
      'title_step1': 'Players',
      'step1_description': 'How many people do you want to play the tournament with?',
      'number_of_players': 'Number of players',
      'title_step2': 'Rounds',
      'step2_description': 'What is the maximum number of rounds you want to play?',
      'number_of_rounds': 'Number of rounds',
      'title_step3': 'Tables',
      'step3_description': 'What is the maximum number of tables you can provide?',
      'number_of_tables': 'Available tables',
      'title_step4': 'Sheet',
      'step4_description': 'Do you need a route card for each player or referee sheets for each round and match? Choose an option.',
      'route_card': 'Route Card',
      'referee_sheet': 'Referee Sheet',
      'button_next': 'NEXT',
      'button_back': 'BACK',
      'button_gen': 'GENERATE',
      'coming_soon': 'Coming soon - be curious',
      'error_wasm': 'Error calling PDF generation - please contact Marcel Kaufmann.',
      'error_download': 'Error downloading PDF - please contact Marcel Kaufmann.',
      'error_timeout': 'The generation encountered a timeout. Your parameters are too hard to solve and not suitable to find an adequate solution in reasonable time.'
    },
    'de': {
      'title': 'TT(C) Match Generator',
      'welcome_title': 'Willkommen!',
      'welcome_subtitle': 'Generiere dir passende Zettel für dein TT-Turnier',
      'welcome_content': 'Auf dieser Seite findest du einen Generator, mit dessen Hilfe du dir in 5 Schritten Laufzettel oder Schiedsrichterzettel zu Einzel- oder Doppleturnieren erstellen kannst. Der Fokus liegt dabei auf möglichst großer Abwechselung in den Gegnern und Mitspielern. Das Projekt befindet sich aktuell im Aufbau und es ist nicht ausgeschlossen, dass du einen Fehler findest oder es noch Verbesserungen an den Algorithmen gibt. Schreib mir gerne, falls du Feedback hast.',
      'title_step0': 'Art des Turniers',
      'step0_description': 'Möchtest du ein Einzel- oder Doppelturnier spielen? Wähle eine Variante.',
      'single': 'Einzel',
      'double': 'Doppel',
      'title_step1': 'Spieler',
      'step1_description': 'Mit wie vielen Personen möchtest du das Turnier spielen?',
      'number_of_players': 'Anzahl Spieler',
      'title_step2': 'Runden',
      'step2_description': 'Wie viele Runden möchtest du maximal spielen?',
      'number_of_rounds': 'Anzahl Runden',
      'title_step3': 'Tische',
      'step3_description': 'Wie viele Tische kannst du für das Turnier nutzen?',
      'number_of_tables': 'Verfügbare Tische',
      'title_step4': 'Zettel',
      'step4_description': 'Möchtest du Laufzettel generieren oder für jede Runde und jedes Spiel ein Schiedrichterzettel? Wähle eine Variante.',
      'route_card': 'Laufzettel',
      'referee_sheet': 'Schiedrichterzettel',
      'button_next': 'WEITER',
      'button_back': 'ZURÜCK',
      'button_gen': 'GENERIEREN',
      'coming_soon': 'Bald verfügbar - seid gespannt',
      'error_wasm': 'Fehler beim Generieren des PDFs - bitte kontaktiere Marcel Kaufmann.',
      'error_download': 'Fehler beim PDF-Download - bitte kontaktiere Marcel Kaufmann.',
      'error_timeout': 'Die Generierung dauert zu lange. Deine Eingaben zur Generierung sind zu komplex, um sie in angemessener Zeit lösen.'
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

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

  String get titleStep4 {
    return _localizedValues[locale.languageCode]!['title_step4']!;
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

  String get step0Description {
    return _localizedValues[locale.languageCode]!['step0_description']!;
  }

  String get single {
    return _localizedValues[locale.languageCode]!['single']!;
  }

  String get double {
    return _localizedValues[locale.languageCode]!['double']!;
  }

  String get step1Description {
    return _localizedValues[locale.languageCode]!['step1_description']!;
  }

  String get step2Description {
    return _localizedValues[locale.languageCode]!['step2_description']!;
  }

  String get step3Description {
    return _localizedValues[locale.languageCode]!['step3_description']!;
  }

  String get numberOfTables {
    return _localizedValues[locale.languageCode]!['number_of_tables']!;
  }

  String get numberOfPlayers {
    return _localizedValues[locale.languageCode]!['number_of_players']!;
  }

  String get numberOfRounds {
    return _localizedValues[locale.languageCode]!['number_of_rounds']!;
  }

  String get step4Description {
    return _localizedValues[locale.languageCode]!['step4_description']!;
  }

  String get routeCard {
    return _localizedValues[locale.languageCode]!['route_card']!;
  }

  String get refereeSheet {
    return _localizedValues[locale.languageCode]!['referee_sheet']!;
  }

  String get errorWasm {
    return _localizedValues[locale.languageCode]!['error_wasm']!;
  }

  String get errorDownload {
    return _localizedValues[locale.languageCode]!['error_download']!;
  }

  String get errorTimeout {
    return _localizedValues[locale.languageCode]!['error_timeout']!;
  }

  String get welcomeTitle {
    return _localizedValues[locale.languageCode]!['welcome_title']!;
  }

  String get welcomeSubtitle {
    return _localizedValues[locale.languageCode]!['welcome_subtitle']!;
  }

  String get welcomeContent {
    return _localizedValues[locale.languageCode]!['welcome_content']!;
  }

}
