import 'dart:async';
import 'dart:js';

import 'package:tournament_cards_website/data/worker/interface.dart';
import 'package:tournament_cards_website/domain/model/AppError.dart';
import 'package:tournament_cards_website/domain/model/WasmServiceResponse.dart';
import 'package:tournament_cards_website/domain/repository/WasmRepository.dart';

class WasmService implements WasmRepository {
  final worker = BackgroundWorker();

  Completer<bool> wasmInitCompleter = Completer();
  Completer<WasmServiceResponse> wasmPDFCompleter = Completer();

  Timer? timeout;

  void handleTimeout() {
    killWasm();
    wasmPDFCompleter.complete(WasmServiceResponse(success: false, error: AppError.PDF_GEN_TIMEOUT));
  }

  @override
  Future<bool> initWasm() {
    // https://fireship.io/snippets/using-js-with-flutter-web/
    context['init_ready'] = (parameter) {
      wasmInitCompleter.complete(true);
    };
    context['pdf_ready'] = (parameter) {
      if(timeout != null && timeout!.isActive){
        timeout!.cancel();
      }
      wasmPDFCompleter.complete(WasmServiceResponse(success: true, response: parameter));
      killWasm();
    };

    context.callMethod('createWorker', []);

    JsObject.fromBrowserObject(context['wasm_worker']).callMethod('postMessage', [
      JsObject.jsify({'command': 'start'})
    ]);
    return wasmInitCompleter.future;
  }

  @override
  Future<WasmServiceResponse> getDoubleCardsPDF(int numberOfPlayers, int numberOfRounds, int drawOption, int numberOfTables, int distributeOption, String languageCode) async {
    wasmInitCompleter = Completer();
    wasmPDFCompleter = Completer();
    try{
      await initWasm();
      timeout = Timer(Duration(seconds: 60), handleTimeout);
      JsObject.fromBrowserObject(context['wasm_worker']).callMethod('postMessage', [
        JsObject.jsify({
          'command': 'generateDouble',
          'data': JsObject.jsify({ 'numberOfPlayers': numberOfPlayers , 'numberOfRounds': numberOfRounds, 'drawOption': drawOption, 'numberOfTables': numberOfTables, 'distributeOption': distributeOption,  'languageCode': languageCode }),
        })
      ]);
    }catch (e){
      if(timeout != null && timeout!.isActive){
        timeout!.cancel();
      }
      wasmPDFCompleter.complete(WasmServiceResponse(success: false, error: AppError.WASM_ERROR));
    }
    return wasmPDFCompleter.future;
  }

  @override
  void killWasm() {
    JsObject.fromBrowserObject(context['wasm_worker']).callMethod('postMessage', [
      JsObject.jsify({'command': 'stop'})
    ]);
    context['wasm_worker'].callMethod('terminate', []);
  }

}
