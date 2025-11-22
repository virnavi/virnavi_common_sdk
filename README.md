# 🛠️ common_sdk

A **comprehensive Flutter utilities package** that provides a collection of essential helper classes and utilities to streamline your Flutter development workflow.

This package includes utilities for logging, dependency injection, stream handling, navigation context management, internet connectivity checks, and more — all designed to reduce boilerplate and improve code maintainability.

## ✨ Features

✅ **Logger** — Centralized logging with correlation IDs for easy debugging  
✅ **Either & Optional** — Functional programming patterns for better error handling  
✅ **ModelStream** — Simplified stream handling with automatic entity-to-model conversion  
✅ **ContextHolder** — Global access to navigation context and overlay  
✅ **InternetUtils** — Easy internet connectivity checks  
✅ **SnackBarHelper** — Simplified snackbar management  
✅ **BaseGetIt** — Streamlined dependency injection setup

## 🚀 Usage

### 1. Logger

A singleton logger with correlation ID support for tracking related log messages.

```dart
import 'package:flutter_utils_package/flutter_utils_package.dart';

void main() {
  // Initialize logger
  Logger.initialize(enableLogging: true);
  
  // Use the logger
  final correlationId = Logger.shared.log(
    'User logged in',
    tag: 'AUTH',
  );
  
  // Use same correlation ID for related logs
  Logger.shared.log(
    'Fetching user profile',
    tag: 'AUTH',
    correlationId: correlationId,
  );
}
```

### 2. Either & Optional

Functional programming utilities for safer error handling and null safety.

**Either:**
```dart
import 'package:flutter_utils_package/flutter_utils_package.dart';

Either<String, int> divide(int a, int b) {
  if (b == 0) {
    return Left('Division by zero');
  }
  return Right(a ~/ b);
}

void main() {
  final result = divide(10, 2);
  
  result.fold(
    (error) => print('Error: $error'),
    (value) => print('Result: $value'),
  );
  
  // Check result type
  if (result.isRight()) {
    print('Success!');
  }
}
```

**Optional:**
```dart
import 'package:flutter_utils_package/flutter_utils_package.dart';

void main() {
  // Create optional values
  final hasValue = Optional.of(42);
  final empty = Optional.empty<int>();
  final nullable = Optional.ofNullable(null);
  
  // Safe data access
  hasValue.ifPresent((data) => print('Value: $data'));
  
  // Provide defaults
  final value = empty.orElse(0);
  
  // Throw on missing data
  try {
    final data = empty.orElseThrow(Exception('No data'));
  } catch (e) {
    print('Caught: $e');
  }
}
```

### 3. ModelStream

Wrapper classes for converting entity streams to model streams with Optional support.

```dart
import 'package:flutter_utils_package/flutter_utils_package.dart';

class UserEntity {
  final String id;
  final String name;
  UserEntity(this.id, this.name);
}

class UserModel {
  final String id;
  final String name;
  UserModel(this.id, this.name);
}

void main() {
  final entityStream = Stream.value(UserEntity('1', 'Shuvo'));
  
  final modelStream = ModelStreamImpl<UserModel, UserEntity>(
    stream: entityStream,
    convertToModel: (entity) {
      if (entity == null) return Optional.empty();
      return Optional.of(UserModel(entity.id, entity.name));
    },
  );
  
  modelStream.listen((optionalModel) {
    optionalModel.ifPresent((model) {
      print('User: ${model.name}');
    });
  });
}
```

**For list streams:**
```dart
final listStream = Stream.value([UserEntity('1', 'Shuvo'), UserEntity('2', 'Shakib')]);

final modelStream = ModelListStreamImpl<UserModel, UserEntity>(
  stream: listStream,
  convertToModel: (entity) {
    if (entity == null) return Optional.empty();
    return Optional.of(UserModel(entity.id, entity.name));
  },
);
```

### 4. Context Holder

Global access to navigation context without passing BuildContext through multiple layers.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_utils_package/flutter_utils_package.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the navigator key
      navigatorKey: ContextHolder.navigatorKey,
      home: const MyHomePage(),
    );
  }
}

// Use from anywhere in your app
void showDialogFromAnywhere() {
  showDialog(
    context: ContextHolder.currentContext,
    builder: (context) => AlertDialog(
      title: const Text('Hello'),
    ),
  );
}
```

### 5. Internet Utils

Check internet connectivity easily.

```dart
import 'package:flutter_utils_package/flutter_utils_package.dart';

Future<void> checkConnection() async {
  final isConnected = await InternetUtils.isInternetConnected();
  
  if (isConnected) {
    print('Internet is available');
  } else {
    print('No internet connection');
  }
}
```

### 6. SnackBar Helper

Simplified snackbar management with automatic cleanup.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_utils_package/flutter_utils_package.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the messenger key
      scaffoldMessengerKey: SnackBarHelper.key,
      home: const MyHomePage(),
    );
  }
}

// Show snackbar from anywhere
void showMessage() {
  SnackBarHelper.showSnackBar(
    const SnackBar(content: Text('Hello!')),
  );
}
```

### 7. BaseGetIt

Simplified dependency injection setup using get_it.

```dart
import 'package:flutter_utils_package/flutter_utils_package.dart';
import 'package:get_it/get_it.dart';

class MyDependencies extends BaseGetIt {
  @override
  void configureDependencies(GetIt getIt) {
    // Register your dependencies
    getIt.registerSingleton<ApiService>(ApiService());
    getIt.registerFactory<UserRepository>(() => UserRepository());
  }
}

void main() {
  final di = MyDependencies();
  
  // Access dependencies
  final apiService = di.get<ApiService>();
  final userRepo = di.get<UserRepository>();
}
```

## 🧠 How It Works

This package provides standalone utility classes that can be used independently or together:

- **Logger** uses a singleton pattern with correlation IDs for tracking related operations
- **Either** and **Optional** implement functional programming patterns for safer data handling
- **ModelStream** classes wrap standard Dart streams to provide automatic conversion and Optional wrapping
- **ContextHolder**, **SnackBarHelper** use GlobalKeys for context-free access to Flutter framework features
- **InternetUtils** provides simple connectivity checks using DNS lookup
- **BaseGetIt** extends get_it functionality with a clean abstraction layer

## 🧰 Dependencies

- [get_it](https://pub.dev/packages/get_it)

## 🧑‍💻 Contributors

* **Mohammed Shakib** ([@shakib1989](https://github.com/shakib1989)) - *Main Library Development*
* **Shuvo Prosad Sarnakar** ([@shuvoprosadsarnakar](https://github.com/shuvoprosadsarnakar)) - *Extensive documentation and getting the project for pub.dev.*

## 🪪 License

This project is licensed under the **MIT License** — see the LICENSE file for details.