import 'AppError.dart';

class WasmServiceResponse{
  bool success;
  var response;
  AppError? error;
  WasmServiceResponse({required this.success, this.response, this.error});
}