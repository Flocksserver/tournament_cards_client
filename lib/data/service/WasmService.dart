import 'dart:async';
import 'dart:js';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tournament_cards_website/data/worker/interface.dart';
import 'package:tournament_cards_website/domain/model/WasmServiceResponse.dart';
import 'package:tournament_cards_website/domain/repository/WasmRepository.dart';

class WasmService implements WasmRepository {
  final worker = BackgroundWorker();

  Completer<bool> wasmInitCompleter = Completer();
  Completer<WasmServiceResponse> wasmPDFCompleter = Completer();

  @override
  Future<bool> initWasm() {
    // https://fireship.io/snippets/using-js-with-flutter-web/
    context['init_ready'] = (parameter) {
      wasmInitCompleter.complete(true);
    };
    context['pdf_ready'] = (parameter) {
      wasmPDFCompleter.complete(WasmServiceResponse(success: true, response: parameter));
    };
    JsObject.fromBrowserObject(context['wasm_worker']).callMethod('postMessage', [
      JsObject.jsify({'command': 'start'})
    ]);
    return wasmInitCompleter.future;
  }

  @override
  Future<WasmServiceResponse> getDoubleCardsPDF(int numberOfPlayers, int numberOfRounds, int drawOption, int numberOfTables, int distributeOption, String languageCode) async {
    wasmPDFCompleter = Completer();
    JsObject.fromBrowserObject(context['wasm_worker']).callMethod('postMessage', [
      JsObject.jsify({
        'command': 'generateDouble',
        'data': JsObject.jsify({ 'numberOfPlayers': numberOfPlayers , 'numberOfRounds': numberOfRounds, 'drawOption': drawOption, 'numberOfTables': numberOfTables, 'distributeOption': distributeOption,  'languageCode': languageCode }),
      })
    ]);
    return wasmPDFCompleter.future;
  }

  @override
  void killWasm() {
    debugPrint("KILL");
    JsObject.fromBrowserObject(context['wasm_worker']).callMethod('postMessage', [
      JsObject.jsify({'command': 'stop'})
    ]);
  }

}
