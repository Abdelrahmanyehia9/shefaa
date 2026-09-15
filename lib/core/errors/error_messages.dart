class AppErrorMessages {
  const AppErrorMessages._();
  static const String unexpectedError = 'حدث خطأ غير متوقع، حاول مرة أخرى';
  static const String networkError = 'تعذر الاتصال بالإنترنت، تحقق من الشبكة';
  static const String timeoutError = 'انتهت مهلة الاتصال، حاول مرة أخرى';
  static const String formatException = 'حدث خطأ في تنسيق البيانات المستلمة';
}

class DatabaseErrorMessages {
  const DatabaseErrorMessages._();

  /// DATABASE
  static const String duplicate = 'هذا العنصر موجود بالفعل';
  static const String foreignKey =
      'لا يمكن إتمام العملية بسبب ارتباط هذا العنصر ببيانات أخرى';
  static const String notNullViolation = 'يجب تعبئة جميع الحقول المطلوبة';
  static const String checkViolation = 'القيمة المدخلة غير صالحة';
  static const String insufficientPrivilege =
      'لا تملك الصلاحية الكافية لتنفيذ هذه العملية';
  static const String undefinedTable = 'الجدول المطلوب غير موجود';
  static const String undefinedColumn = 'الحقل المطلوب غير موجود';
  static const String undefinedFunction = 'الدالة المطلوبة غير موجودة';
  static const String invalidInputSyntax = 'صيغة البيانات المدخلة غير صحيحة';
  static const String readOnlyTransaction =
      'لا يمكن تنفيذ هذه العملية، القاعدة في وضع القراءة فقط';
  static const String connectionFailure = 'فشل الاتصال بقاعدة البيانات';
  static const String internalError = 'حدث خطأ داخلي في قاعدة البيانات';

  /// POSTGREST
  static const String noRows = 'لم يتم العثور على أي نتائج';
  static const String parseError = 'تعذر تحليل البيانات المستلمة';
  static const String invalidBody = 'محتوى الطلب غير صالح';
  static const String invalidRange = 'النطاق المطلوب غير صالح';
  static const String invalidPath = 'المسار المطلوب غير صالح';
  static const String invalidMethod = 'طريقة الطلب غير مدعومة';

  static const String connectionError = 'تعذر الاتصال بالخادم';
  static const String timeout = 'انتهت مهلة الاتصال بقاعدة البيانات';

  static const String staleRelation = 'تعذر الوصول للبيانات، حاول تحديث الصفحة';
  static const String ambiguousRelation =
      'العلاقة بين البيانات غير واضحة، يرجى مراجعة الطلب';
  static const String staleFunction = 'الدالة المطلوبة قديمة أو غير متزامنة';
  static const String columnNotFound = 'الحقل المطلوب غير موجود في الجدول';
  static const String tableNotFound = 'الجدول المطلوب غير موجود';

  static const String jwtInvalid = 'رمز الدخول غير صالح';
  static const String jwtMissing = 'رمز الدخول غير موجود';
  static const String jwtClaimsInvalid = 'بيانات رمز الدخول غير صحيحة';
  static const String unknown = 'حدث خطأ غير معروف';
}

class AuthErrorMessages {
  const AuthErrorMessages._();

  static const String invalidEmail = 'البريد الإلكتروني غير صالح';
  static const String emailExists = 'هذا البريد الإلكتروني مستخدم بالفعل';
  static const String emailNotConfirmed = 'لم يتم تأكيد البريد الإلكتروني بعد';
  static const String emailProviderDisabled =
      'تسجيل الدخول بالبريد الإلكتروني غير مفعّل حاليًا';
  static const String emailConflictIdentityNotDeletable =
      'لا يمكن حذف هذه الهوية بسبب تعارضها مع بريد إلكتروني آخر';
  static const String invalidCredentials =
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';
  static const String userNotFound = 'لم يتم العثور على المستخدم';
  static const String userAlreadyExists = 'هذا المستخدم مسجل بالفعل';
  static const String userBanned = 'تم حظر هذا الحساب';
  static const String weakPassword = 'كلمة المرور ضعيفة، اختر كلمة مرور أقوى';
  static const String samePassword = 'كلمة المرور الجديدة مطابقة للقديمة';
  static const String reauthenticationNeeded =
      'يلزم إعادة تسجيل الدخول لإتمام هذه العملية';
  static const String reauthenticationNotValid = 'فشلت عملية إعادة المصادقة';
  static const String otpExpired = 'انتهت صلاحية رمز التحقق';
  static const String otpDisabled = 'رمز التحقق غير مفعّل';
  static const String mfaVerificationFailed = 'فشل التحقق من المصادقة الثنائية';
  static const String mfaChallengeExpired =
      'انتهت صلاحية تحدي المصادقة الثنائية';
  static const String tooManyEnrolledMfaFactors =
      'تم الوصول للحد الأقصى من عوامل المصادقة الثنائية';
  static const String sessionExpired =
      'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مجددًا';
  static const String refreshTokenNotFound = 'رمز التحديث غير موجود';
  static const String refreshTokenAlreadyUsed = 'تم استخدام رمز التحديث مسبقًا';
  static const String noAuthorization = 'ليس لديك صلاحية للقيام بهذا الإجراء';
  static const String oauthProviderNotSupported = 'مزود تسجيل الدخول غير مدعوم';
  static const String providerDisabled = 'مزود تسجيل الدخول هذا غير مفعّل';
  static const String providerEmailNeedsVerification =
      'يجب التحقق من البريد الإلكتروني الخاص بمزود تسجيل الدخول';
  static const String userSsoManaged =
      'هذا الحساب يُدار عبر تسجيل الدخول الموحد (SSO)';
  static const String overRequestRateLimit =
      'تم تجاوز الحد المسموح من المحاولات، حاول لاحقًا';
  static const String overEmailSendRateLimit =
      'تم تجاوز الحد المسموح لإرسال رسائل البريد الإلكتروني';
  static const String overSmsSendRateLimit =
      'تم تجاوز الحد المسموح لإرسال الرسائل النصية';
  static const String phoneExists = 'رقم الهاتف مستخدم بالفعل';
  static const String phoneNotConfirmed = 'لم يتم تأكيد رقم الهاتف بعد';
  static const String phoneProviderDisabled =
      'تسجيل الدخول برقم الهاتف غير مفعّل حاليًا';
  static const String smsSendFailed = 'فشل إرسال الرسالة النصية';
  static const String flowStateExpired =
      'انتهت صلاحية عملية تسجيل الدخول، حاول من جديد';
  static const String flowStateNotFound =
      'لم يتم العثور على عملية تسجيل الدخول';
  static const String unexpectedFailure = 'حدث خطأ غير متوقع، حاول مرة أخرى';
  static const String signInCanceled = 'تم إلغاء عملية تسجيل الدخول';
  static const String interrupted = 'تم مقاطعة العملية قبل اكتمالها';
  static const String accountExistsWithDifferentCredential =
      'يوجد حساب بنفس البريد مسجل بطريقة دخول مختلفة';
  static const String userConfigError = 'حدث خطأ في إعدادات المستخدم';
  static const String providerConfigurationError =
      'حدث خطأ في إعدادات مزود تسجيل الدخول';
  static const String uiUnavailable = 'واجهة تسجيل الدخول غير متاحة حاليًا';
  static const String unknown = 'حدث خطأ غير معروف';
}

class StorageErrorMessage {
  const StorageErrorMessage._();

  static const String noSuchBucket = 'حاوية التخزين غير موجودة';
  static const String noSuchKey = 'الملف المطلوب غير موجود';
  static const String noSuchUpload = 'عملية الرفع غير موجودة';
  static const String invalidJWT = 'رمز الدخول للتخزين غير صالح';
  static const String invalidRequest = 'طلب التخزين غير صالح';
  static const String tenantNotFound = 'الجهة المطلوبة غير موجودة';
  static const String entityTooLarge = 'حجم الملف أكبر من الحد المسموح به';
  static const String internalError = 'حدث خطأ داخلي في التخزين';
  static const String resourceAlreadyExists = 'هذا العنصر موجود بالفعل';
  static const String invalidBucketName = 'اسم حاوية التخزين غير صالح';
  static const String invalidKey = 'اسم الملف غير صالح';
  static const String invalidRange = 'النطاق المطلوب غير صالح';
  static const String invalidMimeType = 'نوع الملف غير مدعوم';
  static const String invalidUploadId = 'معرّف عملية الرفع غير صالح';
  static const String keyAlreadyExists = 'يوجد ملف بنفس الاسم بالفعل';
  static const String bucketAlreadyExists =
      'يوجد حاوية تخزين بنفس الاسم بالفعل';
  static const String databaseTimeout = 'حدث خطأ في قاعدة بيانات التخزين';
  static const String invalidSignature = 'توقيع الطلب غير صالح';
  static const String signatureDoesNotMatch = 'توقيع الطلب غير مطابق';
  static const String accessDenied = 'تم رفض الوصول إلى هذا الملف';
  static const String resourceLocked = 'هذا العنصر مقفل حاليًا، حاول لاحقًا';
  static const String databaseError = 'حدث خطأ في قاعدة بيانات التخزين';
  static const String missingContentLength = 'حجم المحتوى غير محدد في الطلب';
  static const String missingParameter =
      'أحد الحقول المطلوبة غير موجود في الطلب';
  static const String invalidUploadSignature = 'توقيع عملية الرفع غير صالح';
  static const String lockTimeout = 'انتهت مهلة انتظار قفل الملف';
  static const String s3Error = 'حدث خطأ في خدمة التخزين';
  static const String s3InvalidAccessKeyId =
      'مفتاح الوصول لخدمة التخزين غير صالح';
  static const String s3MaximumCredentialsLimit =
      'تم الوصول للحد الأقصى من بيانات اعتماد التخزين';
  static const String invalidChecksum = 'تحقق سلامة الملف غير مطابق';
  static const String missingPart = 'أحد أجزاء الملف مفقود';
  static const String slowDown = 'عدد الطلبات كبير جدًا، يرجى الانتظار قليلًا';
  static const String unknown = 'حدث خطأ غير متوقع، حاول مرة أخرى';
}

class ImagePickerErrorMessage {
  const ImagePickerErrorMessage._();
  static const String unknown = 'حدث خطأ غير معروف أثناء اختيار الصورة';
  static const String sizeExceeded = 'حجم الصورة أكبر من الحد المسموح به';
  static const String errorCropping = 'حدث خطأ أثناء قص الصورة';
  static const String errorPick = 'حدث خطأ أثناء اختيار الصورة';
}
