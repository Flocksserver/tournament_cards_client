import 'package:flutter/material.dart';

class SingleDoubleStep{
  Step build(BuildContext context, int stepNumber, int currentStep) {
    return Step(
      title: Text('Einzel / Doppel'),
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