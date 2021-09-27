import 'package:flutter/material.dart';

import '../AppConstants.dart';

class Spinner{

  static bool isSpinning = false;

  static showProgress(BuildContext context) {
    if(!isSpinning){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: CircularProgressIndicator(
              backgroundColor: AppConstants.mainColor.shade400,
            ),
          ));
      isSpinning = true;
    }
  }

  static hideProgress(BuildContext context) {
    if(isSpinning){
      Navigator.pop(context);
      isSpinning = false;
    }
  }
}