
import 'package:tournament_cards_website/domain/model/WasmServiceResponse.dart';

abstract class WasmRepository{
  Future<WasmServiceResponse> getDoubleCardsPDF(int numberOfPlayers,int numberOfRounds,int drawOption,int numberOfTables,int distributeOption,String languageCode);
  void initWasm();
  void killWasm();
}