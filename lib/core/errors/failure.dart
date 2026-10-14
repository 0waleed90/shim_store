import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  Failures(this.errorMessage);
}



class ServerFailure extends Failures {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with API service');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with API service');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with API service');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad SSL Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode ?? 500,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to API service was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(
          'Connection error: ${dioException.message ?? "Unable to reach server"}',
        );
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return ServerFailure('Network error: Unable to connect to server');
        }
        return ServerFailure(
          dioException.message ?? 'Unexpected Error, please try again!',
        );
      default:
        return ServerFailure('Opps there was an error, please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (response is Map) {
      final msg = response['message'];
      if (msg is List) {
        return ServerFailure(msg.join(', '));
      } else if (msg is String) {
        return ServerFailure(msg);
      }
      final err = response['error'];
      if (err is String) {
        return ServerFailure(err);
      }
    }
    if (statusCode == 404) {
      return ServerFailure('Your request not found, please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, please try later');
    } else {
      return ServerFailure('Opps there was an error ($statusCode), please try again');
    }
  }
}