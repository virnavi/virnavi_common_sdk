import 'dart:async';

import '../models/models.dart';

abstract class ModelStream<Model> extends Stream<Optional<Model>> {
  bool get initialDataSent;
}
