import 'package:dio/dio.dart';

class APIError {
  static String getErrorMessage(Exception e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.cancel:
          return "Request to server was cancelled";
        case DioExceptionType.connectionError:
          return "Connection to server failed due to internet connection";
        case DioExceptionType.connectionTimeout:
          return "Connection timeout with server";
        case DioExceptionType.receiveTimeout:
          return "Receive timeout in connection with server";
        case DioExceptionType.sendTimeout:
          return "Send timeout in connection with server";
        case DioExceptionType.badCertificate:
          return "Bad certificate in connection with server";
        case DioExceptionType.badResponse:
          return fromResponse(e.response);
        default:
          return "Oops, Unexpected Error Occurred, Please try again later";
      }
    } else {
      return "Oops, Unexpected Error Occurred, Please try again later";
    }
  }

  static String fromResponse(Response? response) {
    final statusCode = response?.statusCode!;
    var responseData = response?.data!;
    String errorMessage =
        'Oops, Unexpected Error Occurred, Please try again later';
    if (response == null) {
      return errorMessage;
    } else {
      print(responseData);
      if (responseData is String) {
        return responseData;
      } else if (responseData.containsKey('error') && responseData['error'] is String) {
        return responseData['error'];
      } else {
        switch (statusCode) {
          case 404:
            errorMessage = 'Your request was not found, Please try again later';
            break;
          case 500:
            errorMessage = 'Internal server error, please try again later';
            break;
          case 503:
            errorMessage = 'Service Unavailable, please try again later';
            break;
          case 400:
            errorMessage = 'Bad request, please try again later';
            break;
          case 401:
            errorMessage = 'Unauthorized, please try again later';
            break;
          case 402:
            errorMessage = 'Payment required, please try again later';
            break;
          case 403:
            errorMessage = errorMessage.isNotEmpty
                ? errorMessage
                : "An error occurred while processing your request";
            break;
          default:
            break;
        }
      }
      if (errorMessage.isEmpty) {
        errorMessage = 'Oops, Unknown Error Occurred, Please try again later';
      }
      return errorMessage;
    }
  }
}