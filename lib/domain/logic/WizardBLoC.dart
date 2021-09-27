import 'dart:async';
import 'dart:typed_data';

import 'package:rxdart/rxdart.dart';

enum WizardNav{
  NEXT,
  BACK
}

class WizardBLoC{

  final _relativeNavigationController = StreamController<WizardNav>();
  Sink<WizardNav> get relativeNavigationSink => _relativeNavigationController.sink;

  final _absoluteNavigationController = StreamController<int>();
  Sink<int> get absoluteNavigationSink => _absoluteNavigationController.sink;

  final _wizardSubject = BehaviorSubject<int>();
  Stream<int> get wizardStream => _wizardSubject.stream;

  int _currentStep = 0;

  WizardBLoC(){
    _relativeNavigationController.stream.listen(_onRelativeNavigation);
    _absoluteNavigationController.stream.listen(_onAbsoluteNavigation);
  }


  void _onRelativeNavigation(WizardNav wizardNav) async{
    switch (wizardNav){
      case WizardNav.NEXT:
        _currentStep ++;
        break;
      case WizardNav.BACK:
        _currentStep ++;
        break;
    }
    _wizardSubject.add(_currentStep);
  }

  void _onAbsoluteNavigation(int step) async{

    _wizardSubject.add(_currentStep);
  }


  void dispose(){
    _relativeNavigationController.close();
    _absoluteNavigationController.close();
    _wizardSubject.close();
  }

}