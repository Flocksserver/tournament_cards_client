import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tournament_cards_website/domain/model/AbsoluteNavigationRequest.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';
import 'package:tournament_cards_website/domain/model/RelativeNavigationRequest.dart';
import 'package:tournament_cards_website/domain/model/StepNavigationResponse.dart';

enum WizardNav{
  NEXT,
  BACK
}

class WizardBLoC{

  final _relativeNavigationController = StreamController<RelativeNavigationRequest>();
  Sink<RelativeNavigationRequest> get relativeNavigationSink => _relativeNavigationController.sink;

  final _absoluteNavigationController = StreamController<AbsoluteNavigationRequest>();
  Sink<AbsoluteNavigationRequest> get absoluteNavigationSink => _absoluteNavigationController.sink;

  final _wizardSubject = BehaviorSubject<StepNavigationResponse>();
  Stream<StepNavigationResponse> get wizardStream => _wizardSubject.stream;

  int _currentStep = 0;

  WizardBLoC(){
    _relativeNavigationController.stream.listen(_onRelativeNavigation);
    _absoluteNavigationController.stream.listen(_onAbsoluteNavigation);
  }


  void _onRelativeNavigation(RelativeNavigationRequest relativeNavigationRequest) async{
    PDFGeneration pdfGenerationNew = relativeNavigationRequest.pdfGeneration;
    switch (relativeNavigationRequest.wizardNav){
      case WizardNav.NEXT:
        if (_currentStep < relativeNavigationRequest.numberOfSteps)
          _currentStep ++;
        break;
      case WizardNav.BACK:
        if (_currentStep != 0)
        _currentStep --;
        break;
    }
    _wizardSubject.add(StepNavigationResponse(currentStep: _currentStep, pdfGeneration: pdfGenerationNew));
  }

  void _onAbsoluteNavigation(AbsoluteNavigationRequest absoluteNavigationRequest) async{
    _currentStep = absoluteNavigationRequest.stepNumber;
    _wizardSubject.add(StepNavigationResponse(currentStep: _currentStep, pdfGeneration: absoluteNavigationRequest.pdfGeneration));
  }


  void dispose(){
    _relativeNavigationController.close();
    _absoluteNavigationController.close();
    _wizardSubject.close();
  }

}