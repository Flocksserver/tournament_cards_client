import 'package:flutter/material.dart';
import 'package:tournament_cards_website/AppConstants.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';

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
                Text(AppLocalizations.of(context).title),
                Padding(
                  padding: EdgeInsets.fromLTRB(_deviceSize.width > _deviceSize.height ? _deviceSize.width * 0.05 : 0.0, 0.0, 0.0, 0.0),
                ),
                //Image.network(AppConstants.einKlangLogo, width: 95, height: 40,)
                // Your widgets here
              ],
            ),
          ),
        ],
      ),

    );
  }
}
