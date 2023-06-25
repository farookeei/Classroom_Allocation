import 'package:dio/dio.dart';

import '../../../config/const/constants.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError,
      {bool isAuthentication = false}) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = Constants.somethingWentWrong;

        if (dioError.response?.statusCode == 500) {
          message = Constants.serverError;
        } else if (dioError.response?.data["error"] != null) {
          message = dioError.response?.data["error"];
        }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'No Internet connection';

          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = Constants.somethingWentWrong;
        break;
    }
  }

  // String _handleError({
  //   int? statusCode,
  //   dynamic error,
  // }) {
  //   if (error['msg'] != "" && error['msg'] != null) {
  //     return error['msg'];
  //   } else {
  //     return Constants.somethingWentWrong;
  //   }

  // switch (error) {
  //   case 400:
  //     return 'Bad request';
  //   case 401:
  //     return 'Unauthorized';
  //   case 403:
  //     return 'Forbidden';
  //   case 404:
  //     return error['message'];
  //   case 500:
  //     return 'Internal server error';
  //   case 502:
  //     return 'Bad gateway';
  //   default:
  //     return 'Oops something went wrong';
  // }
  // }

  @override
  String toString() => message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}
