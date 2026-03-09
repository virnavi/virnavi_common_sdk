import 'dart:async';

import '../models/models.dart';
import 'model_stream.dart';

/// A [ModelStream] that converts a list-entity stream into a single-model
/// stream.
///
/// Each `List<Entity>?` emitted by [stream] is reduced to a single value:
/// the first element is passed to [convertToModel], or [Optional.empty] is
/// emitted when the list is `null` or empty.
///
/// ```dart
/// final stream = ModelListStreamImpl<UserModel, UserEntity>(
///   stream: userListStream,
///   convertToModel: (entity) => entity == null
///       ? Optional.empty()
///       : Optional.of(UserModel.fromEntity(entity)),
/// );
/// stream.listen((optional) => optional.ifPresent(updateUi));
/// ```
class ModelListStreamImpl<Model, Entity> extends ModelStream<Model> {
  late final Stream<List<Entity>?> _stream;

  /// The active subscription to the source stream.
  StreamSubscription? subscription;

  /// The controller that broadcasts converted model values.
  final controller = StreamController<Optional<Model>>();

  bool _dataSent = false;

  @override
  bool get initialDataSent => _dataSent;

  /// Converts the first [Entity] from a list (or `null`) to an
  /// [Optional]-wrapped [Model].
  Optional<Model> Function(Entity? entity) convertToModel;

  /// Creates a [ModelListStreamImpl] that listens to [stream] immediately.
  ModelListStreamImpl({
    required Stream<List<Entity>?> stream,
    required this.convertToModel,
  }) {
    _stream = stream;
    init();
  }

  /// Starts listening to the source stream.
  void init() {
    subscription = _stream.listen(
      (data) {
        final optionalData = (data == null || data.isEmpty)
            ? Optional.empty<Model>()
            : convertToModel(data[0]);
        _dataSent = true;
        controller.add(optionalData);
      },
      onDone: () {
        controller.close();
      },
      onError: (Object error, StackTrace stackTrace) {
        controller.addError(error, stackTrace);
      },
      cancelOnError: false,
    );
  }

  @override
  Future<void> dispose() async {
    subscription?.cancel();
  }

  @override
  StreamSubscription<Optional<Model>> listen(
      void Function(Optional<Model> event)? onData,
      {Function? onError,
      void Function()? onDone,
      bool? cancelOnError}) {
    return controller.stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
