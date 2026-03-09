part of 'models.dart';

/// A model that carries no fields, used as a placeholder return type for
/// operations that succeed without returning data.
class EmptyModel {
  /// Creates an [EmptyModel].
  EmptyModel();

  /// Serialises this model to an empty JSON map.
  Map<String, dynamic> toJson() => {};

  /// Deserialises an [EmptyModel] from [json] (all fields are ignored).
  factory EmptyModel.fromJson(Map<String, dynamic> json) => EmptyModel();
}
