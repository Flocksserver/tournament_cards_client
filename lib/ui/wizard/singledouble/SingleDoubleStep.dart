import 'package:flutter/material.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';
import 'package:tournament_cards_website/domain/model/TournamentType.dart';
import 'package:tournament_cards_website/ui/wizard/singledouble/SingleDoubleItem.dart';

class SingleDoubleStep {
  Step build(BuildContext context, int stepNumber, int currentStep, PDFGeneration pdfGeneration) {
    return Step(
      title: Text(AppLocalizations.of(context).titleStep0),
      content: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 200),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context).step0Description),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SingleDoubleItem(buttonText: AppLocalizations.of(context).single, type: TournamentType.SINGLE, pdfModel: pdfGeneration),
                SingleDoubleItem(buttonText: AppLocalizations.of(context).double, type: TournamentType.DOUBLE, pdfModel: pdfGeneration),
              ],
            ),
          ],
        ),
      ),
      isActive: currentStep >= stepNumber,
      state: currentStep == stepNumber ? StepState.editing : (currentStep > stepNumber ? StepState.complete : StepState.disabled),
    );
  }
}
