/*
https://github.com/deakjahn/flutter_isolate_web <-- does not work
With rust wasm we need to import js modules instead of js script. Therefore we cannot use
the standard dart2js worker api
*/
import init, {create_run_sheet_for_double} from "./wasm/tournament_cards_generator.js";

self.addEventListener('message', function(e) {
  var data = e.data;
  switch (data.command) {
    case 'start':
      init();
      self.postMessage({"command":"init_ready"});
      break;
    case 'generateDouble':
       var bytes = create_run_sheet_for_double(data.data.numberOfPlayers, data.data.numberOfRounds, data.data.drawOption, data.data.numberOfTables, data.data.distributeOption, data.data.languageCode);
       self.postMessage({"command":"pdf_ready", "data": bytes});
       break;
    case 'stop':
      self.close();
      break;
    default:
  };
}, false);
