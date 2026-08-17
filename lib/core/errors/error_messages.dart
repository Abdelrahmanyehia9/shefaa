class ErrorMessages {
  const ErrorMessages._();

  /// Server Errors
  static const String networkErrorMessage = 'error.network_error_message';
  static const String serverErrorMessage = 'error.server_error_message';
  static const String unknownErrorMessage = 'error.unknown_error_message';
  static const String unAuthorizedErrorMessage =
      'error.un_authorized_error_message';
  static const String validationErrorMessage = 'error.validation_error_message';
  static const String connectionError = 'error.connection_error';
  static const String accessForbidden = 'error.access_forbidden';
  static const String notFound = 'error.not_found';

  /// Firebase auth Exceptions Messages
  static const String emailInUse = 'error.email_in_use';
  static const String inValidEmail = 'error.in_valid_email';
  static const String weakPassword = 'error.weak_password';
  static const String userNotFound = 'error.user_not_found';
  static const String wrongPassword = 'error.wrong_password';
  static const String userDisabled = 'error.user_disabled';
  static const String tooManyRequests = 'error.too_many_requests';
  static const String operationNotAllowed = 'error.operation_not_allowed';
  static const String accountExist = 'error.account_exist';
  static const String invalidCredentials = 'error.invalid_credentials';
}
