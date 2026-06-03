# flutter_mvvm_starter

A production-ready Flutter starter template using **Feature-based MVVM + Repository pattern**.
Built on the Flutter official MVVM approach — no boilerplate Clean Architecture, no UseCase layer.

**Stack:** Flutter 3.x · Dart 3.x · Cubit · GetIt · Dio · GoRouter · Freezed · Firebase

---

## Architecture

```
View  ──►  Cubit (ViewModel)  ──►  Repository  ──►  DataSource (HTTP)
```

- **View** — StatelessWidget pages. Provide Cubits via `BlocProvider(create: (_) => injector<MyCubit>())`.
- **Cubit** — Single-responsibility state machine. Emits `DefaultState<T>` or `PaginationState<T>`.
- **Repository** — Parses HTTP responses into domain types. Returns `Either<Failure, T>`.
- **DataSource** — Thin HTTP wrapper. Extends `ApiClient`, calls `requestAPI()`.

### Folder structure

```
lib/
├── app/                      # MyApp root widget
├── config/
│   ├── app_constant.dart
│   ├── routes/               # app_routes.dart + app_router.dart (GoRouter)
│   └── theme/                # app_color, app_dimensions, app_text_style, app_theme
├── core/
│   ├── di/
│   │   ├── service_locator.dart
│   │   └── modules/          # network_module, auth_module, ...
│   ├── error/failure.dart
│   ├── local/                # session_manager (secure), local_data_source (prefs)
│   └── network/              # api_client, api_endpoints, auth_interceptor
├── features/
│   └── <feature>/
│       ├── data/             # models/, datasources/, repositories/
│       ├── view/             # pages/, widgets/
│       └── viewModel/        # Cubits
├── services/firebase/
└── utils/                    # app_dialog, extensions, validators, components
```

---

## Getting Started

### 1. Clone and rename

```bash
git clone <repo-url> my_app
cd my_app
```

Rename the package in `pubspec.yaml`, `android/`, `ios/`, and all import paths:

```bash
# Quick rename (replace flutter_mvvm_starter with your app name)
find . -type f \( -name "*.dart" -o -name "*.yaml" -o -name "*.gradle" -o -name "*.plist" \) \
  | xargs sed -i '' 's/flutter_mvvm_starter/my_app/g'
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure the API base URL

Open `lib/core/network/api_endpoints.dart` and set your backend URL:

```dart
static const String baseUrl = 'https://your-api.example.com/api/v1';
```

### 4. Set up Firebase (optional but recommended)

1. Create a project at [console.firebase.google.com](https://console.firebase.google.com).
2. Add Android (`google-services.json` → `android/app/`) and iOS (`GoogleService-Info.plist` → `ios/Runner/`).
3. Generate `lib/firebase_options.dart`:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
4. In `lib/main.dart`, update the Firebase init block:
   ```dart
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   await FcmService.init();
   ```

### 5. Run code generation

Always run this after editing any `@freezed` model or `@JsonSerializable` class:

```bash
dart run build_runner build --delete-conflicting-outputs --force-jit
```

> **Note:** The standard `dart run build_runner build` may fail with `'dart compile' does not support build hooks`. Always append `--force-jit`.

### 6. Update theme tokens

| File | What to change |
|---|---|
| `lib/config/theme/app_color.dart` | Brand colors |
| `lib/config/theme/app_text_style.dart` | Font sizes |
| `lib/config/theme/app_dimensions.dart` | Spacing / radius |
| `lib/config/app_constant.dart` | Font family name, asset paths |
| `pubspec.yaml` → `fonts:` | Uncomment and set the Inter (or your) font |

### 7. Run the app

```bash
flutter run
```

The app starts at `SplashPage` → checks stored session → routes to `SignInPage` or `HomePage`.

---

## Adding a New Feature

> Example: adding a `dashboard` feature.

**Step 1 — Create files**

```
lib/features/dashboard/
  data/
    models/         dashboard_model.dart
    datasources/    dashboard_data_source.dart
    repositories/   dashboard_repository.dart
  view/
    pages/          dashboard_page.dart
    widgets/        (optional sub-widgets)
  viewModel/        dashboard_cubit.dart
```

**Step 2 — Add route**

In `lib/config/routes/app_routes.dart`:
```dart
static const String dashboard = 'dashboard';
```

In `lib/config/routes/app_router.dart`:
```dart
GoRoute(
  path: '/${AppRoutes.dashboard}',
  name: AppRoutes.dashboard,
  builder: (_, __) => const DashboardPage(),
),
```

**Step 3 — Register DI**

Create `lib/core/di/modules/dashboard_module.dart`:
```dart
class DashboardModule {
  static void register() {
    injector.registerLazySingleton(() => DashboardDataSource(dio: injector<Dio>()));
    injector.registerLazySingleton(() => DashboardRepository(dataSource: injector()));
    injector.registerFactory(() => DashboardCubit(repository: injector()));
  }
}
```

In `lib/core/di/service_locator.dart`:
```dart
DashboardModule.register();
```

**Step 4 — Run code generation**

```bash
dart run build_runner build --delete-conflicting-outputs --force-jit
```

---

## User Roles

Edit `lib/features/auth/data/models/user_role.dart` to match your API's role values:

```dart
enum UserRole {
  @JsonValue('ADMIN')   admin('ADMIN',   'Admin'),
  @JsonValue('MANAGER') manager('MANAGER', 'Manager'),
  @JsonValue('STAFF')   staff('STAFF',   'Staff');

  const UserRole(this.value, this.label);
  final String value;
  final String label;
}
```

---

## Key Packages

| Purpose | Package | Version |
|---|---|---|
| State management | `flutter_bloc` | ^9.1.1 |
| DI | `get_it` | ^9.2.0 |
| HTTP | `dio` | ^5.9.1 |
| Error handling | `dartz` | ^0.10.1 |
| Router | `go_router` | ^17.0.1 |
| Code generation | `freezed` + `json_serializable` | ^3.2.3 / ^6.11.2 |
| Secure storage | `flutter_secure_storage` | ^9.0.0 |
| Preferences | `shared_preferences` | ^2.5.4 |
| Dialogs | `flutter_smart_dialog` | ^4.9.8+9 |
| Firebase | `firebase_core` + `firebase_messaging` | ^4.6.0 / ^16.1.3 |

---

## Architecture Guidelines

For detailed rules and AI-agent instructions, see [`.github/copilot-instructions.md`](.github/copilot-instructions.md).

