
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';

class AbsoluteNavigationRequest {
  int stepNumber;
  PDFGeneration pdfGeneration;

  AbsoluteNavigationRequest({required this.stepNumber, required this.pdfGeneration});
}
