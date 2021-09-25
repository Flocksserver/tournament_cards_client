

import 'dart:html';
import 'dart:typed_data';
import 'dart:js';

import 'package:tournament_cards_website/domain/model/AppError.dart';
import 'package:tournament_cards_website/domain/model/DownloadServiceResponse.dart';
import 'package:tournament_cards_website/domain/repository/DownloadRepository.dart';

class DownloadService implements DownloadRepository{
  @override
  Future<DownloadServiceResponse> callDownload(Uint8List pdf) async {
    try{
      context.callMethod("webSaveAs", [
        Blob([pdf]),
        "Tournament.pdf"
      ]);
      return Future.value(DownloadServiceResponse(success: true));
    }catch (e){
      return Future.value(DownloadServiceResponse(success: false, error: AppError.CALL_DOWNLOAD_ERROR));

    }

  }

}