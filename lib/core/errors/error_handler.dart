import 'dart:io';
import 'package:shefaa/core/errors/error_messages.dart';
import 'package:shefaa/core/errors/exceptions.dart';

class ErrorHandler {
  static AppException handleError(Object error) {
    if (error is SocketException) {
      return NetworkException(
        message: ErrorMessages.connectionError,
        code: 'NETWORK_ERROR',
        originalError: error,
      );
    }
    if (error is FormatException) {
      return ValidationException(
        message: ErrorMessages.validationErrorMessage,
        code: 'FORMAT_ERROR',
        originalError: error,
      );
    }
    return UnknownException(
      message: ErrorMessages.unknownErrorMessage,
      code: 'UNKNOWN_ERROR',
      originalError: error,
    );
  }
}
