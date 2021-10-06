import 'package:flutter/material.dart';
import 'package:tournament_cards_website/App.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:tournament_cards_website/ui/language/LanguageItem.dart';
import 'package:tournament_cards_website/ui/language/RadioModel.dart';

class WebsiteAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final Size _deviceSize;

  WebsiteAppBar(this._deviceSize);

  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(_deviceSize.width > _deviceSize.height ? _deviceSize.width * 0.05 : 0.0, 0.0, 0.0, 0.0),
                  child: Text(AppLocalizations.of(context).title),
                ),
                // Your widgets here
              ],
            ),
            actions: <Widget>[
              LanguageItem(RadioModel(isSelected: App.of(context)?.getLocale()?.languageCode == "de", buttonText: "de")),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0,_deviceSize.width > _deviceSize.height ? _deviceSize.width * 0.05 : 30.0, 0.0),
                child: LanguageItem(RadioModel(isSelected: App.of(context)?.getLocale()?.languageCode == "en", buttonText: "en")),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
