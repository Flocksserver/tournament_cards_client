import 'AppError.dart';

class DownloadServiceResponse{
  bool success;
  AppError? error;
  DownloadServiceResponse({required this.success, this.error});
}