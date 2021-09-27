import 'dart:async';
import 'dart:typed_data';

import 'package:rxdart/rxdart.dart';
import 'package:tournament_cards_website/Injector.dart';
import 'package:tournament_cards_website/domain/model/AppError.dart';
import 'package:tournament_cards_website/domain/model/DownloadServiceResponse.dart';
import 'package:tournament_cards_website/domain/model/PDFGeneration.dart';
import 'package:tournament_cards_website/domain/model/TournamentType.dart';
import 'package:tournament_cards_website/domain/model/WasmServiceResponse.dart';

class GeneratorBLoC{

  final _generatePDFController = StreamController<PDFGeneration>();
  Sink<PDFGeneration> get generatePDFSink => _generatePDFController.sink;

  final _startDownloadController = StreamController<Uint8List>();
  Sink<Uint8List> get startDownloadSink => _startDownloadController.sink;

  final _pdfSubject = BehaviorSubject<Uint8List>();
  Stream<Uint8List> get pdfStream => _pdfSubject.stream;

  final _loadingSubject = BehaviorSubject<bool>();
  Stream<bool> get loadingStream => _loadingSubject.stream;

  final _errorMessageSubject = BehaviorSubject<AppError>();
  Stream<AppError> get errorMessageStream => _errorMessageSubject.stream;


  GeneratorBLoC(){
    _generatePDFController.stream.listen(_onGeneratePDF);
    _startDownloadController.stream.listen(_onStartDownload);
  }


  void _onGeneratePDF(PDFGeneration request) async{
    _loadingSubject.add(true);
    WasmServiceResponse response;
    switch (request.type){
      case TournamentType.DOUBLE:
        response = await Injector().wasmService.getDoubleCardsPDF(
            request.numberOfPlayers,
            request.numberOfRounds,
            request.drawOption,
            request.numberOfTables,
            request.distributeOption,
            request.languageCode
        );
        break;
      case TournamentType.SINGLE:
        response = WasmServiceResponse(success: true);
        break;
    }

      if(response.success){
        _pdfSubject.add(response.response);
      } else {
        _errorMessageSubject.add(response.error);
      }
      _loadingSubject.add(false);

  }

  void _onStartDownload(Uint8List pdf) async{
    DownloadServiceResponse response = await Injector().downloadService.callDownload(pdf);
    if(response.success == false){
      _errorMessageSubject.add(response.error);
    }
  }


  void dispose(){
    Injector().wasmService.killWasm();
    _errorMessageSubject.close();
    _generatePDFController.close();
    _startDownloadController.close();
    _loadingSubject.close();
    _pdfSubject.close();
  }

}