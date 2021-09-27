import 'package:tournament_cards_website/ui/model/MatchType.dart';

class SingleDoubleRadioModel {
  bool isSelected;
  String buttonText;
  MatchType matchType;

  SingleDoubleRadioModel({required this.isSelected, required this.buttonText, required this.matchType});
}