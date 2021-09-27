import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';

class RelativeNavigationRequest {
  WizardNav wizardNav;
  int numberOfSteps;

  RelativeNavigationRequest({required this.wizardNav, required this.numberOfSteps});
}
