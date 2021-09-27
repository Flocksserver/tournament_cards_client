import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tournament_cards_website/AppConstants.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';
import 'package:tournament_cards_website/domain/model/TournamentType.dart';

class SingleDoubleItem extends StatelessWidget {
  final String buttonText;
  final TournamentType type;
  final PDFGeneration pdfModel;

  SingleDoubleItem({required this.buttonText,required this.type, required this.pdfModel });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
      child: InkWell(
        splashColor: AppConstants.mainColor,
        onTap: () {
          if(type == TournamentType.SINGLE){
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context).comingSoon,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              webBgColor: '#000000',
              timeInSecForIosWeb: 3,
              webPosition: 'center',
            );
          }

        },
        child: Container(
          child: Container(
            height: 150.0,
            width: 150.0,
            child: Center(
              child: Text(buttonText),
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: pdfModel.type == type ? AppConstants.mainColor : AppConstants.greyColor),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ),
      ),
    );
  }
}
