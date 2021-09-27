import 'package:flutter/material.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';

class PlayersStep{
  Step build(BuildContext context, int stepNumber, int currentStep) {
    return Step(
      title: Text(AppLocalizations.of(context).titleStep1),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Email Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
      isActive: currentStep >= stepNumber,
      state: currentStep == stepNumber ? StepState.editing : (currentStep > stepNumber ? StepState.complete : StepState.disabled),
    );
  }
}