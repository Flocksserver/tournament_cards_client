import 'package:flutter/material.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/domain/logic/GeneratorBLoC.dart';
import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';
import 'package:tournament_cards_website/domain/model/PDFGenerationRequest.dart';
import 'package:tournament_cards_website/domain/model/RelativeNavigationRequest.dart';
import 'package:tournament_cards_website/domain/model/TournamentType.dart';

class WizardStepper extends StatelessWidget {
  final List<Step> steps;
  final int currentStep;
  final WizardBLoC wizardBLoC;
  final GeneratorBLoC generatorBLoC;

  WizardStepper({required this.steps, required this.currentStep, required this.wizardBLoC, required this.generatorBLoC});

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
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 48.0),
            child: Row(
              children: <Widget>[
                TextButton(
                  onPressed: () =>  currentStep == steps.length - 1 ?
                  generatorBLoC.generatePDFSink.add(PDFGenerationRequest(type: TournamentType.DOUBLE, numberOfPlayers: 40, numberOfRounds: 12, drawOption: 0, numberOfTables: 10, distributeOption: 0, languageCode: "de"))
                      : wizardBLoC.relativeNavigationSink.add(RelativeNavigationRequest(wizardNav: WizardNav.NEXT, numberOfSteps: steps.length - 1)),
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
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 8.0),
                  child: TextButton(
                    onPressed: () => wizardBLoC.relativeNavigationSink.add(RelativeNavigationRequest(wizardNav: WizardNav.BACK, numberOfSteps: steps.length - 1)),
                    style: TextButton.styleFrom(
                      primary: cancelColor,
                      padding: buttonPadding,
                      shape: buttonShape,
                    ),
                    child: Text(AppLocalizations.of(context).buttonBack),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onStepTapped: (step) => wizardBLoC.absoluteNavigationSink.add(step),
      steps: steps,
    );
  }
}
