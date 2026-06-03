# Copilot Instructions — flutter_mvvm_starter

This file defines the architecture, conventions, and rules for this project.
Follow these instructions for every code suggestion, generation, or refactor.

---

## Architecture

**Pattern: Feature-based MVVM + Repository**

- No UseCases / No full Clean Architecture boilerplate.
- Data flows in one direction: **View → Cubit (ViewModel) → Repository → DataSource**
- Each feature is self-contained under `lib/features/<feature_name>/`.

```
lib/
├── app/                        # MyApp widget (MaterialApp.router)
├── config/
│   ├── app_constant.dart       # Global constants (paths, font family)
│   ├── routes/
│   │   ├── app_routes.dart     # Route name string constants
│   │   └── app_router.dart     # GoRouter instance + navigatorKey
│   └── theme/
│       ├── app_color.dart      # Color tokens
│       ├── app_dimensions.dart # Spacing / radius / size constants
│       ├── app_text_style.dart # Type scale
│       └── app_theme.dart      # ThemeData (lightTheme getter)
├── core/
│   ├── di/
│   │   ├── service_locator.dart         # GetIt injector + ServiceLocator
│   │   └── modules/
│   │       ├── network_module.dart      # Dio registration
│   │       └── <feature>_module.dart   # Per-feature DI registrations
│   ├── error/
│   │   └── failure.dart                # Sealed Failure hierarchy
│   ├── local/
│   │   ├── session_keys.dart           # Key constants
│   │   ├── session_manager.dart        # FlutterSecureStorage (tokens + user JSON)
│   │   └── local_data_source.dart      # SharedPreferences (non-sensitive prefs)
│   └── network/
│       ├── api_client.dart             # Abstract base class for DataSources
│       ├── api_endpoints.dart          # URL constants
│       └── interceptors/
│           └── auth_interceptor.dart   # Bearer token + 401 refresh + 403 logout
├── features/
│   └── <feature>/
│       ├── data/
│       │   ├── datasources/   # HTTP calls — extend ApiClient
│       │   ├── models/        # Freezed + json_serializable models
│       │   └── repositories/  # Parse responses → Either<Failure, T>
│       ├── view/
│       │   ├── pages/         # Full-screen widgets (route targets)
│       │   └── widgets/       # Reusable sub-widgets for the feature
│       └── viewModel/         # Cubits (one per logical action)
├── services/
│   └── firebase/
│       └── fcm_service.dart   # Firebase Messaging init
└── utils/
    ├── app_dialog.dart             # SmartDialog wrappers (loading/success/error/confirm)
    ├── bloc/states/
    │   ├── default_state.dart      # DefaultState<T> — single-result Cubit state
    │   └── pagination_state.dart   # PaginationState<T> — paginated list state
    ├── components/
    │   └── shimmer_container.dart  # Loading shimmer placeholder
    ├── extensions/
    │   ├── context_extension.dart  # textTheme, colorScheme, sw, sh shortcuts
    │   ├── date_extension.dart     # DateTime formatters
    │   ├── num_extension.dart      # Number formatters
    │   └── string_extension.dart   # String utilities
    └── validators/
        └── form_validators.dart    # MultiValidator factory methods
```

---

## Key Rules

### Naming
- Feature folders: `snake_case` (e.g., `user_profile`, `dashboard`)
- Classes: `PascalCase`
- Files: `snake_case.dart`
- Cubits live in `viewModel/` (not `cubit/` or `bloc/`)
- Pages live in `view/pages/`, widgets in `view/widgets/`

### State Management — Cubits only
- Use `Cubit<DefaultState<T>>` for single-result operations.
- Use `Cubit<PaginationState<T>>` for paginated lists.
- **Never** use `Bloc` (with events) unless the feature has genuinely complex event-driven logic.
- Emit states in this order: `loading` → `success` / `fail` / `requiresAction`.

```dart
// ✅ Correct Cubit pattern
class GetUserCubit extends Cubit<DefaultState<UserModel>> {
  final UserRepository _repo;
  GetUserCubit({required UserRepository repo})
      : _repo = repo, super(const DefaultState.init());

  Future<void> getUser(String id) async {
    emit(const DefaultState.loading());
    final result = await _repo.getUser(id);
    result.fold(
      (failure) => emit(DefaultState.fail(failure)),
      (user)    => emit(DefaultState.success(user)),
    );
  }
}
```

### Error Handling — Either<Failure, T>
- Repository methods always return `Either<Failure, T>` from `dartz`.
- Use `ServerFailure`, `NetworkFailure`, or `SystemFailure` from `core/error/failure.dart`.
- Never throw exceptions from repositories — catch them and wrap in `Left(...)`.

```dart
// ✅ Correct repository pattern
Future<Either<Failure, UserModel>> getUser(String id) async {
  final result = await requestAPI(() => dio.get('/users/$id'));
  return result.fold(
    Left.new,
    (response) => Right(UserModel.fromJson(response.data['data'])),
  );
}
```

### DataSources — extend ApiClient
- Each feature has its own `DataSource` class. No god-object data sources.
- All HTTP calls go through `requestAPI()` inherited from `ApiClient`.

```dart
class UserDataSource extends ApiClient {
  const UserDataSource({required super.dio});

  Future<Either<Failure, Response>> getUser(String id) =>
      requestAPI(() => dio.get('/users/$id'));
}
```

### Models — Freezed + json_serializable
- All models use `@freezed` with `json_serializable`.
- Always add both `part` directives:
  ```dart
  part 'my_model.g.dart';
  part 'my_model.freezed.dart';
  ```
- After editing any model, run: `dart run build_runner build --delete-conflicting-outputs --force-jit`
- Use `@JsonKey(defaultValue: ...)` on nullable or defaultable fields.

### Dependency Injection — GetIt
- Global accessor: `injector` (from `service_locator.dart`)
- **Cubits** → `registerFactory` (new instance per use)
- **Repositories / DataSources** → `registerLazySingleton`
- **Dio / SessionManager** → `registerLazySingleton`
- Register each feature in its own `<feature>_module.dart` under `core/di/modules/`.
- Call `<Feature>Module.register()` from `ServiceLocator.injectDependencies()`.

### Routing — GoRouter
- Route name strings are constants in `AppRoutes`.
- Navigate with `context.goNamed(AppRoutes.xxx)`.
- All routes are declared in `AppRouter.goRouter`.
- Use `AppRouter.navigatorKey` (not a new key) for programmatic navigation.

### UI Guidelines
- Use `context.textTheme.*` and `context.colorScheme.*` (via `ContextExtension`) — never `Theme.of(context)` directly.
- Spacing and sizes come from `AppDimensions` — never hard-code pixel values.
- Colors come from `AppColors` / `context.colorScheme` — never hard-code color hex values inline.
- Loading dialogs: `AppDialog.showLoading()` / `AppDialog.dismiss()`.
- Error dialogs: `AppDialog.showError(message: failure.message)`.
- Show dialogs in `BlocListener`, not in `BlocBuilder`.

### BlocProvider pattern on pages
```dart
// ✅ Always provide from injector at the page level
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<MyCubit>(),
      child: const _MyView(),
    );
  }
}
```

---

## Adding a New Feature — Checklist

When adding a new feature `foo_bar`, create these files in order:

```
lib/features/foo_bar/
  data/
    models/         foo_bar_model.dart        ← @freezed + @JsonSerializable
    datasources/    foo_bar_data_source.dart  ← extends ApiClient
    repositories/   foo_bar_repository.dart   ← Either<Failure, T> returns
  view/
    pages/          foo_bar_page.dart         ← BlocProvider(create: (_) => injector<FooBarCubit>())
    widgets/        (sub-widgets as needed)
  viewModel/        foo_bar_cubit.dart        ← Cubit<DefaultState<FooBarModel>>
```

Then:
1. Add route name to `AppRoutes`.
2. Add `GoRoute` to `AppRouter.goRouter`.
3. Create `lib/core/di/modules/foo_bar_module.dart` and register deps.
4. Call `FooBarModule.register()` inside `ServiceLocator.injectDependencies()`.
5. Run `dart run build_runner build --delete-conflicting-outputs --force-jit`.

---

## Dependencies Quick Reference

| Purpose | Package |
|---|---|
| State management | `flutter_bloc` (Cubit only) |
| DI | `get_it` |
| HTTP | `dio` |
| Error handling | `dartz` (`Either`) |
| Router | `go_router` |
| Code generation | `freezed` + `json_serializable` + `build_runner` |
| Secure storage (tokens) | `flutter_secure_storage` |
| Preferences | `shared_preferences` |
| Dialogs | `flutter_smart_dialog` |
| SVG | `flutter_svg` |
| Image cache | `cached_network_image` |
| Shimmer | `fade_shimmer` |
| Firebase | `firebase_core` + `firebase_messaging` |
| Form validation | `form_field_validator` |

---

## Build Commands

```bash
# Code generation (REQUIRED after editing any @freezed or @JsonSerializable model)
dart run build_runner build --delete-conflicting-outputs --force-jit

# Run app
flutter run

# Analyze
flutter analyze

# Tests
flutter test
```

> **Note:** The standard `dart run build_runner build` may fail with
> `'dart compile' does not support build hooks`. Always use `--force-jit`.
