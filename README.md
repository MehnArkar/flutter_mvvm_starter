# flutter_mvvm_starter

A Flutter starter template built on **Feature-based MVVM + Repository** pattern.
Clone, rename, and start building — the architecture, DI, networking, auth scaffold,
and theming are already wired up.

**Stack:** Flutter 3 · Dart 3 · Cubit · GetIt · Dio · GoRouter · Freezed · Firebase

---

## What's Included

- Feature-based folder structure — one self-contained module per feature
- `DefaultState<T>` and `PaginationState<T>` sealed Cubit states
- `AuthInterceptor` — automatic Bearer token injection and 401 token refresh with request queuing
- `SessionManager` (secure storage) + `LocalDataSource` (shared preferences), both constructor-injected
- `AppDialog` — loading, success, error, and confirm dialogs (SmartDialog)
- `AppTheme`, `AppColors`, `AppDimensions`, `AppTextStyle` — ready-to-brand token system
- GoRouter with a `navigatorKey` shared with the auth interceptor
- Demo auth flow (sign-in → session → splash routing) — no real backend required

---

## Architecture

```
View  ──►  Cubit (ViewModel)  ──►  Repository  ──►  DataSource (HTTP)
```

| Layer | What it does |
|---|---|
| **View** | Renders UI, dispatches Cubit calls, listens to state with `BlocListener` |
| **Cubit** | Emits `DefaultState<T>`, calls repositories, manages session lifecycle |
| **Repository** | Parses raw `Response` → typed model, returns `Either<Failure, T>` |
| **DataSource** | Executes HTTP via `requestAPI()`, returns raw `Either<Failure, Response>` |

Each feature lives under `lib/features/<feature>/` with `data/`, `view/`, and `viewModel/` sub-folders.
A Use Case layer is omitted by default — add one only when logic is shared across features or complex enough to test in isolation.

For full coding rules see [`.github/copilot-instructions.md`](.github/copilot-instructions.md).

### Folder structure

```
lib/
├── app/                      # MyApp root widget
├── config/
│   ├── app_constant.dart     # Global constants
│   ├── routes/               # AppRoutes (names) + AppRouter (GoRouter)
│   └── theme/                # AppColor, AppDimensions, AppTextStyle, AppTheme
├── core/
│   ├── di/
│   │   ├── service_locator.dart          # GetIt injector
│   │   └── modules/                      # network_module, auth_module, …
│   ├── error/failure.dart                # ServerFailure / NetworkFailure / SystemFailure
│   ├── local/
│   │   ├── session_keys.dart             # Storage key constants
│   │   ├── session_manager.dart          # FlutterSecureStorage — tokens + user JSON
│   │   └── local_data_source.dart        # SharedPreferences — non-sensitive prefs
│   └── network/
│       ├── api_client.dart               # Abstract base for DataSources
│       ├── api_endpoints.dart            # URL constants
│       └── interceptors/auth_interceptor.dart
├── features/
│   └── <feature>/
│       ├── data/             # models/, datasources/, repositories/
│       ├── view/             # pages/, widgets/
│       └── viewModel/        # Cubits
├── services/firebase/        # FcmService (init + listeners)
└── utils/                    # AppDialog, extensions, validators, shimmer, states
```

---

## Getting Started

### 1. Clone and rename

```bash
git clone <repo-url> my_app
cd my_app
```

Rename the package using the included `change_app_package_name` tool:

```bash
flutter pub run change_app_package_name:main com.yourcompany.myapp
```

Then update the `name` and `description` fields in `pubspec.yaml`.

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set the API base URL

Open `lib/core/network/api_endpoints.dart`:

```dart
static const String baseUrl = 'https://your-api.example.com/api/v1';
```

### 4. Configure Firebase (optional)

Skip this step if your app doesn't use Firebase.

1. Create a project at [console.firebase.google.com](https://console.firebase.google.com).
2. Add your config files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
3. Generate `lib/firebase_options.dart`:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
4. In `lib/main.dart`, update the Firebase init block:
   ```dart
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   ```
5. Call `FcmService.init()` after the Firebase block to enable push notifications:
   ```dart
   await FcmService.init();
   ```

### 5. Run code generation

Required after editing any `@freezed` model or `@JsonSerializable` class:

```bash
dart run build_runner build --delete-conflicting-outputs
```

> If this fails with `'dart compile' does not support build hooks`, append `--force-jit`:
> `dart run build_runner build --delete-conflicting-outputs --force-jit`

### 6. Update theme tokens

| File | What to change |
|---|---|
| `lib/config/theme/app_color.dart` | Brand colors |
| `lib/config/theme/app_text_style.dart` | Font sizes and weights |
| `lib/config/theme/app_dimensions.dart` | Spacing, radius, button height |
| `lib/config/app_constant.dart` | Font family name, asset paths |
| `pubspec.yaml` → `fonts:` | Uncomment and point to your `.ttf` files |

### 7. Run the app

```bash
flutter run
```

The app opens at `SplashPage` → reads the stored session → routes to `SignInPage` or `HomePage`.

> **Demo mode:** The auth feature uses stub data — any valid email and password will sign in.
> Replace `AuthRepository.signIn` with a real API call when connecting your backend.

---

## Customizing Auth

### Connect a real backend

1. In `lib/features/auth/data/repositories/auth_repository.dart`, replace the stub `signIn` implementation with:
   ```dart
   final result = await _dataSource.signIn(email: email, password: password);
   return result.fold(
     left,
     (response) => right((
       token: response.data['token'] as String,
       refreshToken: response.data['refreshToken'] as String,
       user: UserModel.fromJson(response.data['user']),
     )),
   );
   ```
2. Ensure your API returns `{ token, refreshToken, user }`.

### User roles

Edit `lib/features/auth/data/models/user_role.dart` to match your API's role values:

```dart
enum UserRole {
  @JsonValue('ADMIN')
  admin(label: 'Admin', value: 'ADMIN'),

  @JsonValue('MANAGER')
  manager(label: 'Manager', value: 'MANAGER'),

  @JsonValue('STAFF')
  staff(label: 'Staff', value: 'STAFF');

  final String label;
  final String value;

  const UserRole({required this.label, required this.value});
}
```

Run `dart run build_runner build --delete-conflicting-outputs` after any model change.

---

## Adding a New Feature

Example: `dashboard`

**Step 1 — Create files**

```
lib/features/dashboard/
  data/
    models/        dashboard_model.dart        ← @freezed + @JsonSerializable
    datasources/   dashboard_data_source.dart  ← extends ApiClient
    repositories/  dashboard_repository.dart   ← Either<Failure, T> returns
  view/
    pages/         dashboard_page.dart         ← BlocProvider → injector<DashboardCubit>()
    widgets/       (sub-widgets as needed)
  viewModel/       dashboard_cubit.dart        ← Cubit<DefaultState<DashboardModel>>
```

**Step 2 — Add route**

`lib/config/routes/app_routes.dart`:
```dart
static const String dashboard = 'dashboard';
```

`lib/config/routes/app_router.dart`:
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
    injector.registerLazySingleton(
      () => DashboardDataSource(dio: injector<Dio>()),
    );
    injector.registerLazySingleton(
      () => DashboardRepository(dataSource: injector<DashboardDataSource>()),
    );
    injector.registerFactory(
      () => DashboardCubit(repository: injector<DashboardRepository>()),
    );
  }
}
```

Call it from `lib/core/di/service_locator.dart`:
```dart
DashboardModule.register();
```

**Step 4 — Generate code**

```bash
dart run build_runner build --delete-conflicting-outputs
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
| Freezed | `freezed` + `freezed_annotation` | ^3.2.3 / ^3.1.0 |
| JSON | `json_serializable` + `json_annotation` | ^6.11.2 / ^4.9.0 |
| Code generation | `build_runner` | ^2.7.1 |
| Secure storage | `flutter_secure_storage` | ^9.0.0 |
| Preferences | `shared_preferences` | ^2.5.4 |
| Dialogs | `flutter_smart_dialog` | ^4.9.8+9 |
| Internationalisation | `intl` | ^0.20.2 |
| SVG | `flutter_svg` | ^2.0.16 |
| Image cache | `cached_network_image` | ^3.4.1 |
| Shimmer | `fade_shimmer` | ^2.4.0 |
| Firebase | `firebase_core` + `firebase_messaging` | ^4.6.0 / ^16.1.3 |
| Form validation | `form_field_validator` | ^1.1.0 |
| Package rename | `change_app_package_name` | ^1.5.0 |

---

## Build Commands

```bash
# Code generation (after any @freezed / @JsonSerializable change)
dart run build_runner build --delete-conflicting-outputs

# Run
flutter run

# Analyze
flutter analyze

# Test
flutter test
```
