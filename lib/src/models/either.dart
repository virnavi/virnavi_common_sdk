part of 'models.dart';

/// A value that holds either a [Left] (typically an error) or a [Right]
/// (typically a success result).
///
/// Use [Either.fold] to handle both cases:
///
/// ```dart
/// Either<Exception, String> result = fetchData();
/// result.fold(
///   (error) => print('Error: $error'),
///   (value) => print('Success: $value'),
/// );
/// ```
class Either<L, R> {
  /// The wrapped value (either type [L] or [R]).
  final dynamic data;

  Either._(this.data);

  /// Returns the [R] value, or calls [callback] if this is a [Left].
  R getOrElse(R Function() callback) {
    if (data is R) {
      return data as R;
    }
    return callback();
  }

  /// Returns `true` if this is a [Left].
  bool isLeft() => this is Left;

  /// Returns `true` if this is a [Right].
  bool isRight() => this is Right;

  /// Swaps [Left] to [Right] and vice-versa.
  Either<R, L> swap() {
    if (data is L) {
      return Right((data as L));
    }
    return Left((data as R));
  }

  /// Applies [onLeft] if this is [Left], or [onRight] if this is [Right].
  FutureOr<T> fold<T>(
    FutureOr<T> Function(L) onLeft,
    FutureOr<T> Function(R) onRight,
  ) {
    log('data type ${data.runtimeType}');
    if (data is L) {
      return onLeft((data as L));
    }
    return onRight((data as R));
  }
}

/// The left (typically error) side of an [Either].
class Left<L, R> extends Either<L, R> {
  /// Creates a [Left] wrapping [data].
  Left(L super.data) : super._();
}

/// The right (typically success) side of an [Either].
class Right<L, R> extends Either<L, R> {
  /// Creates a [Right] wrapping [data].
  Right(R super.data) : super._();
}
