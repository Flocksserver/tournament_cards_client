import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tournament_cards_website/AppConstants.dart';
import 'package:tournament_cards_website/AppLocalizations.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoBoxWidget extends StatelessWidget {
  final Size _deviceSize;
  final double _maxWidth;

  InfoBoxWidget(this._deviceSize, this._maxWidth);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: _maxWidth, minWidth: 500),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 6.0),
                child: Text(
                  AppLocalizations.of(context).welcomeTitle,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, height: 1.2),
                ),
              ),
              Text(
                AppLocalizations.of(context).welcomeSubtitle,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: Color(0xFF999999), height: 1.2),
              ),
              SizedBox(
                height: 44.0,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 480),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context).welcomeContent1,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black, height: 1.8),
                      ),
                      TextSpan(
                        text: " " + AppLocalizations.of(context).feedback + " ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppConstants.mainColor, height: 1.8),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(AppConstants.mailtoURI.toString());
                          },
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).welcomeContent2,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black, height: 1.8),
                      ),
                    ],
                  )

                ),
              ),
            ],
          ),
        ));
  }
}
