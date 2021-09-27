import 'package:flutter/material.dart';
import 'package:tournament_cards_website/domain/logic/WizardBLoC.dart';

class WizardStepper extends StatelessWidget {
  final List<Step> steps;
  final int currentStep;
  final WizardBLoC wizardBLoC;

  WizardStepper({required this.steps, required this.currentStep, required this.wizardBLoC});

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
                            onPressed: () => wizardBLoC.relativeNavigationSink.add(WizardNav.NEXT),
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
                            child: Text("WEITER"),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 8.0),
                            child: TextButton(
                              onPressed: () => wizardBLoC.relativeNavigationSink.add(WizardNav.BACK),
                              style: TextButton.styleFrom(
                                primary: cancelColor,
                                padding: buttonPadding,
                                shape: buttonShape,
                              ),
                              child: Text("ZURÜCK"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
               },
      onStepTapped: (step) => wizardBLoC.absoluteNavigationSink.add(step),
      //onStepContinue: () => wizardBLoC.relativeNavigationSink.add(WizardNav.NEXT),
      //onStepCancel: () => wizardBLoC.relativeNavigationSink.add(WizardNav.BACK),
      steps: steps,
    );
  }
}
