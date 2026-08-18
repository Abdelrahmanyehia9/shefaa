class _AppValidationMessages {
  const _AppValidationMessages();

  static const String cannotBeEmpty = 'لا يمكن أن يكون الحقل فارغًا';
  static const String passwordTooWeak = 'كلمة المرور ضعيفة';
  static const String passwordsDoNotMatch = 'كلمتا المرور غير متطابقتين';
  static const String invalidEmailAddress = 'عنوان البريد الإلكتروني غير صالح';
  static const String invalidPhoneNumber = 'رقم الهاتف غير صالح';
  static const String thisField = 'هذا الحقل';
}

class AppValidation {
  AppValidation._();

  static String? _checkNullOrEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${_AppValidationMessages.cannotBeEmpty}';
    }
    return null;
  }

  static String? validateRequired(
    String? value, {
    String fieldName = _AppValidationMessages.thisField,
  }) {
    return _checkNullOrEmpty(value, fieldName);
  }

  static String? validatePassword(String? password) {
    final emptyCheck = _checkNullOrEmpty(
      password,
      _AppValidationMessages.thisField,
    );
    if (emptyCheck != null) return emptyCheck;

    if (!AppRegex.isValidPassword(password!)) {
      return _AppValidationMessages.passwordTooWeak;
    }
    return null;
  }

  static String? validatePasswordConfirmation(
    String? password,
    String? confirmPassword,
  ) {
    final confirmCheck = _checkNullOrEmpty(
      confirmPassword,
      _AppValidationMessages.thisField,
    );
    if (confirmCheck != null) return confirmCheck;

    if (password != confirmPassword) {
      return _AppValidationMessages.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateEmail(String? email, [bool required = false]) {
    if (required) {
      final emptyCheck = _checkNullOrEmpty(
        email,
        _AppValidationMessages.thisField,
      );
      if (emptyCheck != null) return emptyCheck;
    }

    if (email == null || email.trim().isEmpty) {
      return null;
    }

    final normalizedEmail = email.trim().toLowerCase();
    if (!AppRegex.isValidEmail(normalizedEmail)) {
      return _AppValidationMessages.invalidEmailAddress;
    }

    return null;
  }

  static String? validateNumber(String? phone, int? maxLength) {
    final emptyCheck = _checkNullOrEmpty(
      phone,
      _AppValidationMessages.thisField,
    );
    if (emptyCheck != null) return emptyCheck;
    if (maxLength != null && phone?.length != maxLength) {
      return _AppValidationMessages.invalidPhoneNumber;
    }
    return null;
  }
}

class AppRegex {
  AppRegex._();

  static bool isValidUsername(String username) =>
      RegExp(r'^[a-zA-Z0-9_]{3,}$').hasMatch(username);
  static bool isValidEmail(String email) => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email);
  static bool isValidEgyptianNumber(String phone) {
    phone = phone.replaceAll(' ', '');
    final egyptianPhoneRegex = RegExp(r'^(0)?1[0,1,2,5][0-9]{8}$');
    return egyptianPhoneRegex.hasMatch(phone);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static bool isValidPassword(String password) {
    return /* hasLowerCase(password) &&
        hasUpperCase(password) &&
        hasNumber(password) &&
        hasSpecialCharacter(password) && */ hasMinLength(password);
  }
}
