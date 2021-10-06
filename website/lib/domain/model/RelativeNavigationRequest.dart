import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';

class RelativeNavigationRequest {
  WizardNav wizardNav;
  int numberOfSteps;
  PDFGeneration pdfGeneration;

  RelativeNavigationRequest({required this.wizardNav, required this.numberOfSteps, required this.pdfGeneration});
}
