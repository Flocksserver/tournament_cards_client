
import 'dart:typed_data';

import 'package:tournament_cards_website/domain/model/DownloadServiceResponse.dart';

abstract class DownloadRepository{
  Future<DownloadServiceResponse> callDownload(Uint8List pdf);
}