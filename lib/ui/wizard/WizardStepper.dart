import 'package:flutter/material.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/domain/logic/GeneratorBLoC.dart';
import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';
import 'package:tournament_cards_website/domain/model/AbsoluteNavigationRequest.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';
import 'package:tournament_cards_website/domain/model/RelativeNavigationRequest.dart';

class WizardStepper extends StatelessWidget {
  final List<Step> steps;
  final int currentStep;
  final WizardBLoC wizardBLoC;
  final GeneratorBLoC generatorBLoC;
  final PDFGeneration pdfModel;

  WizardStepper({required this.steps, required this.currentStep, required this.wizardBLoC, required this.generatorBLoC, required this.pdfModel});

  @override
  Widget build(BuildContext context) {
    final Color cancelColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    const OutlinedBorder buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2)));
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Stepper(
      type: StepperType.vertical,
      physics: ScrollPhysics(),
      currentStep: currentStep,
      controlsBuilder: (BuildContext context, { VoidCallback? onStepContinue, VoidCallback? onStepCancel }) {
        return Container(
          margin: EdgeInsets.only(top: 16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsetsDirectional.only(start: 8.0),
                  child: currentStep == 0 ? Container() : TextButton(
                    onPressed: () => wizardBLoC.relativeNavigationSink.add(RelativeNavigationRequest(wizardNav: WizardNav.BACK, numberOfSteps: steps.length - 1, pdfGeneration: pdfModel)),
                    style: TextButton.styleFrom(
                      primary: cancelColor,
                      padding: buttonPadding,
                      shape: buttonShape,
                    ),
                    child: Text(AppLocalizations.of(context).buttonBack),
                  ),
                ),
                SizedBox(width: 16),
                TextButton(
                  onPressed: () =>  currentStep == steps.length - 1 ?
                  generatorBLoC.generatePDFSink.add(pdfModel)
                      : wizardBLoC.relativeNavigationSink.add(RelativeNavigationRequest(wizardNav: WizardNav.NEXT, numberOfSteps: steps.length - 1, pdfGeneration: pdfModel)),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled) ? null : colorScheme.onPrimary;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled) ? null : colorScheme.primary;
                    }),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(buttonPadding),
                    shape: MaterialStateProperty.all<OutlinedBorder>(buttonShape),
                  ),
                  child: currentStep == steps.length - 1 ? Text(AppLocalizations.of(context).buttonGen) : Text(AppLocalizations.of(context).buttonNext),
                ),
              ],
            ),
          ),
        );
      },

          /*(BuildContext context, ControlsDetails details) {
        return Container(
          margin: EdgeInsets.only(top: 16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsetsDirectional.only(start: 8.0),
                  child: currentStep == 0 ? Container() : TextButton(
                    onPressed: () => wizardBLoC.relativeNavigationSink.add(RelativeNavigationRequest(wizardNav: WizardNav.BACK, numberOfSteps: steps.length - 1, pdfGeneration: pdfModel)),
                    style: TextButton.styleFrom(
                      primary: cancelColor,
                      padding: buttonPadding,
                      shape: buttonShape,
                    ),
                    child: Text(AppLocalizations.of(context).buttonBack),
                  ),
                ),
                SizedBox(width: 16),
                TextButton(
                  onPressed: () =>  currentStep == steps.length - 1 ?
                  generatorBLoC.generatePDFSink.add(pdfModel)
                      : wizardBLoC.relativeNavigationSink.add(RelativeNavigationRequest(wizardNav: WizardNav.NEXT, numberOfSteps: steps.length - 1, pdfGeneration: pdfModel)),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled) ? null : colorScheme.onPrimary;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled) ? null : colorScheme.primary;
                    }),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(buttonPadding),
                    shape: MaterialStateProperty.all<OutlinedBorder>(buttonShape),
                  ),
                  child: currentStep == steps.length - 1 ? Text(AppLocalizations.of(context).buttonGen) : Text(AppLocalizations.of(context).buttonNext),
                ),
              ],
            ),
          ),
        );
      },
      */
      onStepTapped: (step) => wizardBLoC.absoluteNavigationSink.add(AbsoluteNavigationRequest(stepNumber: step, pdfGeneration: pdfModel)),
      steps: steps,
    );
  }
}
