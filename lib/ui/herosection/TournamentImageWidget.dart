import 'package:flutter/material.dart';

import '../../AppConstants.dart';

class TournamentImageWidget extends StatelessWidget {
  final double _maxWidth;
  final bool _isOnTop;

  TournamentImageWidget(this._maxWidth, this._isOnTop);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: _maxWidth,
      ),
      child: Padding(
          padding: EdgeInsets.only(bottom: _isOnTop ? 32 : 0),
         child: ClipOval(
            child: Image(
              image: AssetImage(AppConstants.tournamentImage),
              //color: AppConstants.mainColor,
              //colorBlendMode: BlendMode.luminosity,
            ),
          )
      )
    );
  }
}
