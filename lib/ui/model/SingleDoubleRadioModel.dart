
import 'package:tournament_cards_website/domain/model/TournamentType.dart';

class SingleDoubleRadioModel {
  bool isSelected;
  String buttonText;
  TournamentType matchType;

  SingleDoubleRadioModel({required this.isSelected, required this.buttonText, required this.matchType});
}