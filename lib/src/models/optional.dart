part of 'models.dart';

enum _OptionalState { empty, hasData }

class Optional<T> {
  static Optional<T> empty<T>() {
    return Optional<T>._(state: _OptionalState.empty);
  }

  static Optional<T> of<T>(T data) {
    return Optional<T>._(data: data, state: _OptionalState.hasData);
  }

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

  bool get hasData {
    if (_state == _OptionalState.hasData && _data != null) return true;
    return false;
  }

  T get data {
    if (!hasData) {
      throw NoSuchElementException();
    }
    return _data!;
  }

  void ifPresent(void Function(T data) action) {
    if (hasData) {
      action(data!);
    }
  }

  Future<void> ifPresentFuture(Future<void> Function(T data) action) async {
    if (hasData) {
      await action(data!);
    }
  }

  T orElse(T data) {
    if (hasData) {
      return _data!;
    }
    return data;
  }

  T orElseThrow(Exception exception) {
    if (!hasData) {
      throw exception;
    }
    return _data!;
  }
}
