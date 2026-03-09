part of 'models.dart';

enum _OptionalState { empty, hasData }

/// A container that may or may not hold a value of type [T].
///
/// Prefer [Optional] over nullable types when you want explicit, chainable
/// absence handling without propagating `null`.
///
/// ```dart
/// final opt = Optional.ofNullable(maybeUser);
/// opt.ifPresent((user) => print(user.name));
/// final name = opt.orElse(defaultUser);
/// ```
class Optional<T> {
  /// Creates an empty [Optional] with no value.
  static Optional<T> empty<T>() {
    return Optional<T>._(state: _OptionalState.empty);
  }

  /// Creates an [Optional] containing [data].
  static Optional<T> of<T>(T data) {
    return Optional<T>._(data: data, state: _OptionalState.hasData);
  }

  /// Creates an [Optional] from a nullable value.
  ///
  /// Returns [Optional.empty] when [data] is `null`.
  static Optional<T> ofNullable<T>(T? data) {
    if (data != null) {
      return of(data);
    }
    return empty();
  }

  late final _OptionalState _state;
  late final T? _data;

  Optional._({T? data, _OptionalState state = _OptionalState.hasData}) {
    if (state == _OptionalState.empty) {
      _state = state;
    } else {
      _data = data;
      _state = state;
    }
  }

  /// Returns `true` if a non-null value is present.
  bool get hasData {
    if (_state == _OptionalState.hasData && _data != null) return true;
    return false;
  }

  /// Returns the contained value.
  ///
  /// Throws [NoSuchElementException] if no value is present.
  T get data {
    if (!hasData) {
      throw NoSuchElementException();
    }
    return _data!;
  }

  /// Calls [action] with the value if one is present; otherwise does nothing.
  void ifPresent(void Function(T data) action) {
    if (hasData) {
      action(data!);
    }
  }

  /// Asynchronously calls [action] with the value if one is present.
  Future<void> ifPresentFuture(Future<void> Function(T data) action) async {
    if (hasData) {
      await action(data!);
    }
  }

  /// Returns the contained value, or [data] if empty.
  T orElse(T data) {
    if (hasData) {
      return _data!;
    }
    return data;
  }

  /// Returns the contained value, or throws [exception] if empty.
  T orElseThrow(Exception exception) {
    if (!hasData) {
      throw exception;
    }
    return _data!;
  }
}
