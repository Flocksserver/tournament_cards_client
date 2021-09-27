import 'package:flutter/material.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/ui/wizard/export/ExportItem.dart';

class ExportStep{
  Step build(BuildContext context, int stepNumber, int currentStep) {
    return Step(
      title: Text(AppLocalizations.of(context).titleStep4),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).step4Description),
            ),
          ),
          Row(
            children: <Widget>[
              ExportItem(buttonText: AppLocalizations.of(context).routeCard, available: true),
              ExportItem(buttonText: AppLocalizations.of(context).refereeSheet, available: false),
            ],
          ),
        ],
      ),
      isActive: currentStep >= stepNumber,
      state: currentStep == stepNumber ? StepState.editing : (currentStep > stepNumber ? StepState.complete : StepState.disabled),
    );
  }
}