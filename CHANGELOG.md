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