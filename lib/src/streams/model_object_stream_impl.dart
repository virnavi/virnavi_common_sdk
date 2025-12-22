import 'dart:async';

import '../models/models.dart';
import 'model_stream.dart';

class ModelListStreamImpl<Model, Entity> extends ModelStream<Model> {
  late final Stream<List<Entity>?> _stream;
  StreamSubscription? subscription;
  final controller = StreamController<Optional<Model>>();
  bool _dataSent = false;

  @override
  bool get initialDataSent => _dataSent;

  Optional<Model> Function(Entity? entity) convertToModel;

  ModelListStreamImpl({
    required Stream<List<Entity>?> stream,
    required this.convertToModel,
  }) {
    _stream = stream;
    init();
  }

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
