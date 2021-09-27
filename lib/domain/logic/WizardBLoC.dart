import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tournament_cards_website/domain/model/RelativeNavigationRequest.dart';

enum WizardNav{
  NEXT,
  BACK
}

class WizardBLoC{

  final _relativeNavigationController = StreamController<RelativeNavigationRequest>();
  Sink<RelativeNavigationRequest> get relativeNavigationSink => _relativeNavigationController.sink;

  final _absoluteNavigationController = StreamController<int>();
  Sink<int> get absoluteNavigationSink => _absoluteNavigationController.sink;

  final _wizardSubject = BehaviorSubject<int>();
  Stream<int> get wizardStream => _wizardSubject.stream;

  int _currentStep = 0;

  WizardBLoC(){
    _relativeNavigationController.stream.listen(_onRelativeNavigation);
    _absoluteNavigationController.stream.listen(_onAbsoluteNavigation);
  }


  void _onRelativeNavigation(RelativeNavigationRequest relativeNavigationRequest) async{
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
    _wizardSubject.add(_currentStep);
  }

  void _onAbsoluteNavigation(int step) async{
    _currentStep = step;
    _wizardSubject.add(_currentStep);
  }


  void dispose(){
    _relativeNavigationController.close();
    _absoluteNavigationController.close();
    _wizardSubject.close();
  }

}