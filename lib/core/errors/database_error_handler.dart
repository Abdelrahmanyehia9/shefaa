import 'package:shefaa/core/errors/error_messages.dart';
import 'package:shefaa/core/errors/exceptions.dart';

class DatabaseErrorCode {
  const DatabaseErrorCode._();

  /// ================= DATABASE (Postgres) =================

  static const duplicate = '23505';
  static const foreignKey = '23503';
  static const notNullViolation = '23502';
  static const checkViolation = '23514';
  static const insufficientPrivilege = '42501';
  static const undefinedTable = '42P01';
  static const undefinedColumn = '42703';
  static const undefinedFunction = '42883';
  static const invalidInputSyntax = '22P02';
  static const readOnlyTransaction = '25006';
  static const connectionFailurePrefix = '08';
  static const internalErrorPrefix = 'XX';

  /// ================= POSTGREST (API) =================

  static const noRows = 'PGRST116';
  static const parseError = 'PGRST100';
  static const invalidBody = 'PGRST102';
  static const invalidRange = 'PGRST103';
  static const invalidPath = 'PGRST125';
  static const invalidMethod = 'PGRST117';
  static const appointmentIsBooked = 'P2002';
  static const unAuthorized = 'APP01';
  static const clinicNotFound = 'APP02';
  static const pastSlot = 'APP03';
  static const paymentNotFound = 'APP04';
  static const paymentFailed = 'APP05';
  static const paymentAlreadyLinked = 'APP06';
  static const doctorNotFound = 'APP07';
  static const invalidSlot = 'APP08';
  static const slotAlreadyBooked = 'APP09';
  static const cantBookWithSameDoctor = 'APP10';

  static const connectionError = 'PGRST000';
  static const connectionInternal = 'PGRST001';
  static const schemaCacheConnection = 'PGRST002';
  static const timeout = 'PGRST003';

  static const staleRelation = 'PGRST200';
  static const ambiguousRelation = 'PGRST201';
  static const staleFunction = 'PGRST202';
  static const columnNotFound = 'PGRST204';
  static const tableNotFound = 'PGRST205';

  static const jwtInvalid = 'PGRST301';
  static const jwtMissing = 'PGRST302';
  static const jwtClaimsInvalid = 'PGRST303';

  static const unknown = 'unknown';
}

class DatabaseErrorHandler {
  const DatabaseErrorHandler._();
  static final Map<String, String> _map = {
    DatabaseErrorCode.unAuthorized: AuthErrorMessages.noAuthorization,
    DatabaseErrorCode.cantBookWithSameDoctor: DatabaseErrorMessages.cantBookWithSameDoctor,
    DatabaseErrorCode.clinicNotFound: DatabaseErrorMessages.clinicNotFound,
    DatabaseErrorCode.pastSlot: DatabaseErrorMessages.pastSlot,
    DatabaseErrorCode.paymentNotFound: DatabaseErrorMessages.paymentNotFound,
    DatabaseErrorCode.paymentFailed: DatabaseErrorMessages.paymentFailed,
    DatabaseErrorCode.paymentAlreadyLinked: DatabaseErrorMessages.paymentAlreadyLinked,
    DatabaseErrorCode.doctorNotFound: DatabaseErrorMessages.doctorNotFound,
    DatabaseErrorCode.invalidSlot: DatabaseErrorMessages.invalidSlot,
    DatabaseErrorCode.slotAlreadyBooked: DatabaseErrorMessages.slotAlreadyBooked,
    DatabaseErrorCode.duplicate: DatabaseErrorMessages.duplicate,
    DatabaseErrorCode.foreignKey: DatabaseErrorMessages.foreignKey,
    DatabaseErrorCode.notNullViolation: DatabaseErrorMessages.notNullViolation,
    DatabaseErrorCode.checkViolation: DatabaseErrorMessages.checkViolation,
    DatabaseErrorCode.insufficientPrivilege:
        DatabaseErrorMessages.insufficientPrivilege,
    DatabaseErrorCode.undefinedTable: DatabaseErrorMessages.undefinedTable,
    DatabaseErrorCode.undefinedColumn: DatabaseErrorMessages.undefinedColumn,
    DatabaseErrorCode.undefinedFunction:
        DatabaseErrorMessages.undefinedFunction,
    DatabaseErrorCode.invalidInputSyntax:
        DatabaseErrorMessages.invalidInputSyntax,
    DatabaseErrorCode.readOnlyTransaction:
        DatabaseErrorMessages.readOnlyTransaction,
    DatabaseErrorCode.noRows: DatabaseErrorMessages.noRows,
    DatabaseErrorCode.parseError: DatabaseErrorMessages.parseError,
    DatabaseErrorCode.invalidBody: DatabaseErrorMessages.invalidBody,
    DatabaseErrorCode.invalidRange: DatabaseErrorMessages.invalidRange,
    DatabaseErrorCode.invalidPath: DatabaseErrorMessages.invalidPath,
    DatabaseErrorCode.invalidMethod: DatabaseErrorMessages.invalidMethod,
    DatabaseErrorCode.connectionError: DatabaseErrorMessages.connectionError,
    DatabaseErrorCode.connectionInternal: DatabaseErrorMessages.connectionError,
    DatabaseErrorCode.schemaCacheConnection:
        DatabaseErrorMessages.connectionError,
    DatabaseErrorCode.timeout: DatabaseErrorMessages.timeout,
    DatabaseErrorCode.staleRelation: DatabaseErrorMessages.staleRelation,
    DatabaseErrorCode.ambiguousRelation:
        DatabaseErrorMessages.ambiguousRelation,
    DatabaseErrorCode.staleFunction: DatabaseErrorMessages.staleFunction,
    DatabaseErrorCode.columnNotFound: DatabaseErrorMessages.columnNotFound,
    DatabaseErrorCode.tableNotFound: DatabaseErrorMessages.tableNotFound,
    DatabaseErrorCode.jwtInvalid: DatabaseErrorMessages.jwtInvalid,
    DatabaseErrorCode.jwtMissing: DatabaseErrorMessages.jwtMissing,
    DatabaseErrorCode.jwtClaimsInvalid: DatabaseErrorMessages.jwtClaimsInvalid,
  };

  static AppException handle(String? code) {
    final c = code;
    final message = _map[c] ?? DatabaseErrorMessages.unknown;
    return DatabaseException(code: c, message: message);
  }
}
