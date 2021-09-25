import 'package:flutter/material.dart';
import 'package:tournament_cards_website/Injector.dart';

import 'App.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector().wasmService.initWasm();
  runApp(App());
}