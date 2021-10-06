
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';

class StepNavigationResponse{
  int currentStep;
  PDFGeneration pdfGeneration;
  StepNavigationResponse({required this.currentStep, required this.pdfGeneration});
}