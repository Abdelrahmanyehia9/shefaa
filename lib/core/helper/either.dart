sealed class Either<L, R> {
  const Either();

  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);
}

final class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);

  @override
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) => onLeft(value);
}

final class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);

  @override
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) => onRight(value);
}

/// Equivalent to void — used when Right has no meaningful value
final class Unit {
  const Unit._();
}

const Unit unit = Unit._();

Either<L, R> left<L, R>(L value) => Left(value);
Either<L, R> right<L, R>(R value) => Right(value);

extension EitherX<L, R> on Either<L, R> {
  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L? get leftOrNull => switch (this) {
    Left<L, R>(value: final value) => value,
    _ => null,
  };

  R? get rightOrNull => switch (this) {
    Right<L, R>(value: final value) => value,
    _ => null,
  };
}
