
import 'data/service/DownloadService.dart';
import 'data/service/WasmService.dart';
import 'domain/repository/DownloadRepository.dart';
import 'domain/repository/WasmRepository.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() => _singleton;

  Injector._internal();

  // ------------- Services

  final WasmRepository _wasmService = WasmService();

  WasmRepository get wasmService {
    return _wasmService;
  }

  final DownloadRepository _downloadService = DownloadService();

  DownloadRepository get downloadService {
    return _downloadService;
  }
}