import 'package:flutter/material.dart';
import 'package:tournament_cards_website/ui/herosection/InfoBoxWidget.dart';
import 'package:tournament_cards_website/ui/herosection/TournamentImageWidget.dart';

class HeroSectionWidget extends StatelessWidget {
  final Size _deviceSize;

  HeroSectionWidget(this._deviceSize);

  final double _maxWidthImage = 637.0;
  final double _maxWidthTextBox = 579.0;

  bool _shouldBreak() {
    return _deviceSize.width > _maxWidthImage + _maxWidthTextBox + _deviceSize.width * 0.05 + _deviceSize.width * 0.05 + 16 + 16;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, _deviceSize.width * 0.05, 16, _deviceSize.width * 0.05),
      child: _shouldBreak()
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(_deviceSize.width > _deviceSize.height ? _deviceSize.width * 0.05 : 0.0, 0.0, 0.0, 0.0),
                ),
                InfoBoxWidget(_deviceSize, _maxWidthTextBox),
                TournamentImageWidget(_maxWidthImage, false),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, _deviceSize.width > _deviceSize.height ? _deviceSize.width * 0.05 : 0.0, 0.0),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TournamentImageWidget(_maxWidthImage, true),
                InfoBoxWidget(_deviceSize, _maxWidthTextBox),
              ],
            ),
    );
  }
}
