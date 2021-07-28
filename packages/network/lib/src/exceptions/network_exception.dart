import 'package:dio/dio.dart';

/// We will have class that can implement exceptions
class NetworkException implements Exception {
  /// Pass the DioError in the constructor
  const NetworkException(this.dioError);

  /// Variable will be used in the class
  final DioError? dioError;
  /// If the error type is not matched, then we will show default error
  final String defaultErrorDetail = 'Something went wrong. Please try again.';

  /// parse the error in this function and get the details
  String getDetail() {
    var detail = defaultErrorDetail;

    return detail;
  }

  /// return a string from the getDetail() method
  @override
  String toString() => getDetail();
}