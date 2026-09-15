import 'package:flutter/foundation.dart';

import 'package:shefaa/core/errors/error_handler.dart';
import 'package:shefaa/core/errors/exceptions.dart';

extension ToAppException on Object {
  AppException toAppException({bool logError = true}) {
    if (kDebugMode && logError) {
      debugPrint('Exception: $this');
      debugPrint('Exception: $runtimeType');
    }
    return ErrorHandler.handleError(this);
  }
}
