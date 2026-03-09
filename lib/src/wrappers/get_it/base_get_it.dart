import 'package:get_it/get_it.dart';

/// An abstraction over [GetIt] that encapsulates dependency registration and
/// resolution in a single class.
///
/// Extend [BaseGetIt] and override [configureDependencies] to register your
/// services. Then use [get] anywhere to resolve them.
///
/// ```dart
/// class AppDI extends BaseGetIt {
///   @override
///   void configureDependencies(GetIt getIt) {
///     getIt.registerSingleton<ApiService>(ApiServiceImpl());
///   }
/// }
///
/// final di = AppDI();
/// final api = di.get<ApiService>();
/// ```
abstract class BaseGetIt {
  final _getIt = GetIt.asNewInstance();

  /// Creates a new instance and immediately calls [configureDependencies].
  BaseGetIt() {
    configureDependencies(_getIt);
  }

  /// Override to register all dependencies with the provided [getIt] instance.
  void configureDependencies(GetIt getIt);

  /// Resolves a registered instance of type [T].
  ///
  /// [instanceName] can be used to distinguish multiple registrations of the
  /// same type. [param1] and [param2] are forwarded to factory registrations
  /// that accept parameters.
  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return _getIt.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  /// Registers [instance] as a singleton of type [T].
  ///
  /// [instanceName] allows multiple singletons of the same type to coexist.
  /// [signalsReady] and [dispose] are forwarded to [GetIt.registerSingleton].
  T registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  }) {
    return _getIt.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: dispose,
    );
  }
}
