import 'dart:async';

import '../models/models.dart';

/// An abstract stream that emits [Optional]-wrapped model values.
///
/// Concrete implementations ([ModelStreamImpl], [ModelListStreamImpl]) convert
/// raw entity streams into typed model streams and must implement [dispose] to
/// cancel the underlying subscription.
abstract class ModelStream<Model> extends Stream<Optional<Model>> {
  /// Whether the stream has emitted at least one value.
  bool get initialDataSent;

  /// Cancels the underlying subscription and releases resources.
  Future<void> dispose();
}
