import 'package:tournament_cards_website/domain/model/TournamentType.dart';

class PDFGenerationRequest {
  TournamentType type;
  int numberOfPlayers;
  int numberOfRounds;
  int drawOption;
  int numberOfTables;
  int distributeOption;
  String languageCode;

  PDFGenerationRequest(
      {required this.type,
      required this.numberOfPlayers,
      required this.numberOfRounds,
      required this.drawOption,
      required this.numberOfTables,
      required this.distributeOption,
      required this.languageCode});
}
