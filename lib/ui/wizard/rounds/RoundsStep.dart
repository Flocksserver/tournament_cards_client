import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';

class RoundsStep {
  Step build(BuildContext context, int stepNumber, int currentStep, PDFGeneration pdfGeneration, TextEditingController numberOfRoundsController) {
    return Step(
      title: Text(AppLocalizations.of(context).titleStep2),
      content: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 200),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context).step2Description),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: TextField(
                  controller: numberOfRoundsController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context).numberOfRounds),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ),
          ],
        ),
      ),
      isActive: currentStep >= stepNumber,
      state: currentStep == stepNumber ? StepState.editing : (currentStep > stepNumber ? StepState.complete : StepState.disabled),
    );
  }
}
