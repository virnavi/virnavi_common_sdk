import 'dart:async';
import '../models/models.dart';
import 'model_stream.dart';

class ModelStreamImpl<Model, Entity> extends ModelStream<Model> {
  late final Stream<Entity?> _stream;
  StreamSubscription? subscription;
  final controller = StreamController<Optional<Model>>();
  bool _dataSent = false;

  @override
  bool get initialDataSent => _dataSent;

  Optional<Model> Function(Entity? entity) convertToModel;

  ModelStreamImpl({
    required Stream<Entity?> stream,
    required this.convertToModel,
  }) {
    _stream = stream;
    init();
  }

  void init() {
    subscription = _stream.listen(
      (data) {
        final optionalData = convertToModel(data);
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
