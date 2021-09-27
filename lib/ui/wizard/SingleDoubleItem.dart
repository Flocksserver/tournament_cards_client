import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tournament_cards_website/AppConstants.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/ui/HomePage.dart';
import 'package:tournament_cards_website/ui/model/MatchType.dart';
import 'package:tournament_cards_website/ui/model/SingleDoubleRadioModel.dart';

class SingleDoubleItem extends StatelessWidget {
  final SingleDoubleRadioModel _item;

  SingleDoubleItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
      child: InkWell(
        splashColor: AppConstants.mainColor,
        onTap: () {
          if(_item.matchType == MatchType.SINGLE){
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
          }else{
            HomePage.of(context)?.matchType = _item.matchType;
          }

        },
        child: Container(
          child: Container(
            height: 100.0,
            width: 100.0,
            child: Center(
              child: Text(_item.buttonText),
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: _item.isSelected ? AppConstants.mainColor : AppConstants.greyColor),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ),
      ),
    );
  }
}
