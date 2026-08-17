import 'package:shefaa/core/errors/exceptions.dart';

enum StateStatus { initial, loading, success, failure, empty }

class BaseState<T> {
  final StateStatus status;
  final T? data;
  final AppException? error;
  final int? id;
  const BaseState.internal({
    required this.status,
    this.data,
    this.error,
    this.id,
  });
  const BaseState.initial() : this.internal(status: StateStatus.initial);
  const BaseState.loading() : this.internal(status: StateStatus.loading);
  const BaseState.empty() : this.internal(status: StateStatus.empty);
  const BaseState.success(T data)
    : this.internal(status: StateStatus.success, data: data);
  const BaseState.failure(AppException error)
    : this.internal(status: StateStatus.failure, error: error);

  BaseState<T> copyWith({
    StateStatus? status,
    T? data,
    AppException? error,
    int? id,
  }) {
    return BaseState.internal(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }

  bool get isInitial => status == StateStatus.initial;
  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isFailure => status == StateStatus.failure;
  bool get isEmpty => status == StateStatus.empty;
}
