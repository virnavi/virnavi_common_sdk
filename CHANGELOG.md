## 0.0.2

### Added
- `EmptyModel` — placeholder model with `toJson()` / `fromJson()` for operations that succeed without returning data.
- `NoSuchElementException` is now exported from the top-level library.
- Full API documentation on all public classes and members.
- Comprehensive test suite (34 tests) covering `Either`, `Optional`, `EmptyModel`, `NameFormatHelper`, `RegexHelper`, `Logger`, and `NoSuchElementException`.

### Changed
- `ModelStream` — added abstract `dispose()` method to the base class.
- `NameFormatHelper` — removed inline comments from implementation.

## 0.0.1

### Added
- Initial release of `virnavi_common_sdk`.
- **Logger** utility with correlation ID support for tracking related log messages across the application.
- **Either** monad implementation for functional error handling with `Left` and `Right` types.
- **Optional** type for safer null handling with methods like `ifPresent()`, `orElse()`, and `orElseThrow()`.
- **ModelStream** utilities for converting entity streams to model streams:
    - `ModelStreamImpl` for single entity streams.
    - `ModelListStreamImpl` for list-based entity streams.
- **ContextHolder** for global access to navigation context, overlay, and navigator state without passing `BuildContext`.
- **InternetUtils** for checking internet connectivity using DNS lookup.
- **SnackBarHelper** for simplified snackbar management with automatic cleanup.
- **BaseGetIt** abstraction layer over `get_it` for streamlined dependency injection configuration.