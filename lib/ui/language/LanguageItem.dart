import 'package:flutter/material.dart';
import 'package:tournament_cards_website/App.dart';
import 'package:tournament_cards_website/AppConstants.dart';
import 'package:tournament_cards_website/ui/model/RadioModel.dart';

class LanguageItem extends StatelessWidget {
  final RadioModel _item;

  LanguageItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
      child: InkWell(
        splashColor: AppConstants.mainColor,
        onTap: () {
          App.of(context)?.setLocale(Locale.fromSubtags(languageCode: _item.buttonText));
        },
        child: Container(
        height: 50.0,
        width: 50.0,
        child: Center(
          child: Text(_item.buttonText,
              style: TextStyle(
                  fontSize: 18.0)),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 3.0, color: _item.isSelected ? AppConstants.mainColor: AppConstants.greyColor),
          ),
        ),
      ),),
    );
  }
}


