import 'package:flutter/material.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/ui/model/MatchType.dart';
import 'package:tournament_cards_website/ui/model/SingleDoubleRadioModel.dart';
import 'package:tournament_cards_website/ui/wizard/SingleDoubleItem.dart';


class SingleDoubleStep{
  Step build(BuildContext context, int stepNumber, int currentStep, MatchType matchType) {
    return Step(
      title: Text(AppLocalizations.of(context).titleStep0),
      content: Row(
        children: <Widget>[
          SingleDoubleItem(SingleDoubleRadioModel(isSelected: matchType == MatchType.SINGLE, buttonText: "Single", matchType: MatchType.SINGLE)),
          SingleDoubleItem(SingleDoubleRadioModel(isSelected: matchType == MatchType.DOUBLE, buttonText: "Double", matchType: MatchType.DOUBLE)),
        ],
      ),
      isActive: currentStep >= stepNumber,
      state: currentStep == stepNumber ? StepState.editing : (currentStep > stepNumber ? StepState.complete : StepState.disabled),
    );
  }
}