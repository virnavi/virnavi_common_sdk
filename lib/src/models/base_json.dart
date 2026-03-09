/// Marker interface for classes that can serialise themselves to JSON.
///
/// Implement this on any model that needs to be converted to a
/// `Map<String, dynamic>` for storage or network transfer.
///
/// ```dart
/// class UserModel implements BaseJson {
///   final String id;
///   final String name;
///   UserModel({required this.id, required this.name});
///
///   @override
///   Map<String, dynamic> toJson() => {'id': id, 'name': name};
/// }
/// ```
abstract class BaseJson {
  /// Converts this object to a JSON-compatible map.
  Map<String, dynamic> toJson();
}
