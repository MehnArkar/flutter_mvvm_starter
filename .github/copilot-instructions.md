# Copilot Instructions — flutter_mvvm_starter

This file defines the architecture, conventions, and coding rules for this project.
Apply these instructions to every code suggestion, generation, or refactor.

---

## Architecture

**Pattern: Feature-based MVVM + Repository**

Data flows in one direction: **View → ViewModel (Cubit) → Repository → DataSource**

Each feature is self-contained under `lib/features/<feature_name>/`.
No Use Case layer by default — add one only when business logic justifies it (see [Use Cases](#use-cases)).

```
lib/
├── app/                         # MyApp — MaterialApp.router entry point
├── config/
│   ├── app_constant.dart        # Global constants
│   ├── routes/
│   │   ├── app_routes.dart      # Route name string constants
│   │   └── app_router.dart      # GoRouter instance + navigatorKey
│   └── theme/
│       ├── app_color.dart       # Color tokens
│       ├── app_dimensions.dart  # Spacing / radius / size constants
│       ├── app_text_style.dart  # Type scale
│       └── app_theme.dart       # ThemeData
├── core/
│   ├── di/
│   │   ├── service_locator.dart         # GetIt injector + initialization
│   │   └── modules/
│   │       ├── network_module.dart      # Dio + AuthInterceptor
│   │       └── <feature>_module.dart   # Per-feature DI registrations
│   ├── error/
│   │   └── failure.dart                # Sealed Failure hierarchy
│   ├── local/
│   │   ├── session_keys.dart           # Key constants for both storage backends
│   │   ├── session_manager.dart        # FlutterSecureStorage — tokens + user JSON
│   │   └── local_data_source.dart      # SharedPreferences — non-sensitive prefs
│   └── network/
│       ├── api_client.dart             # Abstract base class for DataSources
│       ├── api_endpoints.dart          # URL constants
│       └── interceptors/
│           └── auth_interceptor.dart   # Bearer token injection + 401 refresh
├── features/
│   └── <feature>/
│       ├── data/
│       │   ├── datasources/   # HTTP calls only — extend ApiClient
│       │   ├── models/        # Freezed + json_serializable models
│       │   └── repositories/  # Parse responses → Either<Failure, T>
│       ├── view/
│       │   ├── pages/         # Full-screen route targets
│       │   └── widgets/       # Feature-scoped reusable widgets
│       └── viewModel/         # Cubits — one per logical operation
├── services/
│   └── firebase/
│       └── fcm_service.dart   # Firebase Messaging init + listeners
└── utils/
    ├── app_dialog.dart             # SmartDialog: loading / success / error / confirm
    ├── bloc/states/
    │   ├── default_state.dart      # DefaultState<T> — single-result operations
    │   └── pagination_state.dart   # PaginationState<T> — paginated lists
    ├── components/
    │   └── shimmer_container.dart  # Loading shimmer placeholder
    ├── extensions/
    │   ├── context_extension.dart  # textTheme, colorScheme, sw, sh, topPadding, bottomPadding
    │   ├── date_extension.dart
    │   ├── num_extension.dart
    │   └── string_extension.dart
    └── validators/
        └── form_validators.dart    # FormValidator factory methods
```

---

## Layer Responsibilities

| Layer | Responsibility | Must NOT |
|---|---|---|
| **View** (Page / Widget) | Render UI, dispatch Cubit methods, react to state in `BlocListener` | Contain business logic, call repositories, access storage |
| **ViewModel** (Cubit) | Emit states, call repositories, manage session lifecycle (sign-in / sign-out) | Render UI, execute HTTP logic, parse JSON |
| **Repository** | Call DataSource, parse raw `Response` → typed model, return `Either<Failure, T>` | Emit states, make UI decisions, access `Dio` directly |
| **DataSource** | Execute HTTP via `requestAPI()`, return raw `Either<Failure, Response>` | Parse JSON into models, catch business errors, know about domain types |
| **SessionManager** | Secure token / user JSON storage (FlutterSecureStorage) | Business logic, non-sensitive data |
| **LocalDataSource** | Non-sensitive preferences (SharedPreferences) | Sensitive data |

A Cubit may inject `SessionManager` directly **only** for session lifecycle operations (saving on sign-in, clearing on logout). All other data access goes through a Repository.

---

## Use Cases

The Use Case layer is **omitted by default**. Add one when any of these apply:

- **Shared logic** — the same business operation is needed by two or more Cubits or features.
- **Complex orchestration** — the operation involves multiple repositories, data transformations, or domain rules that belong between the Cubit and Repository.
- **Independent testability** — a critical business rule warrants its own unit test, separate from repository or cubit tests.

**Do not add a Use Case** for straightforward repository calls (fetch / save / delete) where the Cubit simply delegates and maps state.

When used, place Use Cases in `domain/usecases/` and inject them into the Cubit instead of the Repository:

```
lib/features/<feature>/
  data/            ← unchanged
  domain/
    usecases/      foo_bar_use_case.dart   ← single public call() method
  view/            ← unchanged
  viewModel/       ← Cubit receives UseCase, not Repository directly
```

---

## Coding Rules

### Naming
- Feature folders: `snake_case` (e.g. `user_profile`, `order_history`)
- Classes: `PascalCase`
- Files: `snake_case.dart`
- Cubits live in `viewModel/` — not `cubit/` or `bloc/`
- Pages in `view/pages/`, widgets in `view/widgets/`

---

### State Management — Cubits only

- `Cubit<DefaultState<T>>` for single-result operations
- `Cubit<PaginationState<T>>` for paginated lists
- Never use `Bloc` (with events) unless the feature has genuinely complex event-driven logic.
- Emit in order: `loading` → `success` / `fail`.

```dart
// ✅ Correct Cubit pattern
class GetUserCubit extends Cubit<DefaultState<UserModel>> {
  final UserRepository _repo;

  GetUserCubit({required UserRepository repo})
      : _repo = repo,
        super(const DefaultState.init());

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

---

### Error Handling — Either<Failure, T>

- Repository methods always return `Either<Failure, T>` from `dartz`.
- Use `ServerFailure`, `NetworkFailure`, or `SystemFailure` from `core/error/failure.dart`.
- Never throw from repositories — catch and return `left(failure)`.
- Use lowercase `left()` / `right()` from dartz, not `Left.new` / `Right(...)`.

```dart
// ✅ Correct repository pattern
Future<Either<Failure, UserModel>> getUser(String id) async {
  final result = await _dataSource.getUser(id);
  return result.fold(
    left,
    (response) => right(UserModel.fromJson(response.data['data'])),
  );
}
```

---

### DataSources — extend ApiClient

- One `DataSource` per feature. No shared god-object data sources.
- All HTTP calls go through `requestAPI()` inherited from `ApiClient`.
- Return raw `Either<Failure, Response>` — no JSON parsing here.

```dart
class UserDataSource extends ApiClient {
  const UserDataSource({required super.dio});

  Future<Either<Failure, Response>> getUser(String id) =>
      requestAPI(() => dio.get('/users/$id'));
}
```

---

### Models — Freezed + json_serializable

- All models use `@freezed` with `json_serializable`.
- Always declare both `part` directives:

```dart
part 'my_model.g.dart';
part 'my_model.freezed.dart';
```

- Use `@JsonKey(defaultValue: ...)` for nullable or defaultable fields.
- After any model edit: `dart run build_runner build --delete-conflicting-outputs`

---

### Dependency Injection — GetIt

- Global accessor: `injector` (from `service_locator.dart`)
- **Cubits** → `registerFactory` — fresh instance per page/provider
- **Repositories / DataSources** → `registerLazySingleton`
- **SessionManager / Dio** → `registerLazySingleton`
- **SharedPreferences** → `registerSingleton` (initialized eagerly in `_registerCore`)
- Register each feature in `lib/core/di/modules/<feature>_module.dart`.
- Call `<Feature>Module.register()` from `ServiceLocator.injectDependencies()`.
- Always resolve from `injector` — never instantiate registered types with `MyClass()`.

---

### Local Storage

| Need | Class | Backend |
|---|---|---|
| Auth tokens, user JSON (sensitive) | `SessionManager` | `FlutterSecureStorage` |
| Feature flags, locale, onboarding (non-sensitive) | `LocalDataSource` | `SharedPreferences` |

`LocalDataSource` is constructor-injected with a `SharedPreferences` instance registered in `ServiceLocator`. No `init()` call is required anywhere.

---

### Routing — GoRouter

- Route name strings are constants in `AppRoutes`.
- Navigate with `context.goNamed(AppRoutes.xxx)`.
- All routes are declared in `AppRouter.goRouter`.
- Use `AppRouter.navigatorKey` — never create a second `GlobalKey<NavigatorState>`.

---

### UI Guidelines

- `context.textTheme.*` and `context.colorScheme.*` via `ContextExtension` — never `Theme.of(context)` directly.
- Sizes and spacing from `AppDimensions` — never hard-code pixel values.
- Colors from `context.colorScheme` / `AppColors` — never hard-code hex values inline.
- Show dialogs inside `BlocListener`, not `BlocBuilder`:
  - `AppDialog.showLoading()` / `AppDialog.dismiss()`
  - `AppDialog.showError(message: failure.message)`
  - `AppDialog.showSuccess(title: ..., message: ...)`
  - `AppDialog.showConfirm(title: ..., onConfirm: ...)`
- Screen dimensions: `context.sw` (width), `context.sh` (height), `context.topPadding`, `context.bottomPadding`.

---

### BlocProvider pattern

```dart
// ✅ Always provide from injector at the page level
class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<UserCubit>(),
      child: const _UserView(),
    );
  }
}
```

---

## Auth Feature — Demo Only

`lib/features/auth/` demonstrates the MVVM + Repository pattern with stub data.
`AuthRepository.signIn` returns a hardcoded user and fake tokens — no real API call is made.

To connect a real backend:
1. Replace the stub in `AuthRepository.signIn` with `_dataSource.signIn(email, password)`.
2. Ensure your API returns `{ token, refreshToken, user }`.
3. Set `ApiEndpoints.baseUrl` to your server URL.

---

## Adding a New Feature — Checklist

For a new feature `foo_bar`:

**Files to create:**
```
lib/features/foo_bar/
  data/
    models/        foo_bar_model.dart        ← @freezed + @JsonSerializable
    datasources/   foo_bar_data_source.dart  ← extends ApiClient
    repositories/  foo_bar_repository.dart   ← Either<Failure, T> returns
  view/
    pages/         foo_bar_page.dart         ← BlocProvider → injector<FooBarCubit>()
    widgets/       (sub-widgets as needed)
  viewModel/       foo_bar_cubit.dart        ← Cubit<DefaultState<FooBarModel>>
```

**Wiring steps:**
1. Add route constant to `AppRoutes`.
2. Add `GoRoute` to `AppRouter.goRouter`.
3. Create `lib/core/di/modules/foo_bar_module.dart`.
4. Call `FooBarModule.register()` from `ServiceLocator.injectDependencies()`.
5. Run `dart run build_runner build --delete-conflicting-outputs`.

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
| Secure storage | `flutter_secure_storage` |
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
# Code generation — required after any @freezed or @JsonSerializable change
dart run build_runner build --delete-conflicting-outputs

# Run app
flutter run

# Analyze
flutter analyze

# Tests
flutter test
```

> **Note:** If the above fails with `'dart compile' does not support build hooks`,
> add the `--force-jit` flag:
> `dart run build_runner build --delete-conflicting-outputs --force-jit`
