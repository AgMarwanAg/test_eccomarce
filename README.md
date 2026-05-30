# Test Ecommerce

A modern, offline-first Flutter e-commerce application demonstrating scalable architecture, production-ready patterns, and premium UI.

## App Features

- **Home**: Featured products, categories, new arrivals, recommendations, and blog sections.
- **Search**: Paginated product search with debounced input and infinite scroll.
- **Product Details**: Full product info with image carousel, sizes, and related content.
- **Cart**: Add, update, remove items with quantity controls, swipe-to-delete, and checkout summary.
- **Offline First**: Hive-backed caching with network fallback for a seamless offline experience.

## Technical Highlights

### State Management & Architecture
- Hybrid BLoC + Cubit with sealed states, Equatable, and cancelable async operations via custom mixins.
- GetIt dependency injection with singletons, lazy singletons, factories, and named repository bindings.
- Feature-first Clean Architecture with full 3 layers (Home) and pragmatic 2 layers (Search, Product Details).
- Repository pattern with abstract contracts, use cases, entities, and model-to-entity mapping.
- SOLID principles applied across API, repository, domain, and presentation layers.

### Networking & Data
- Custom Dio client (GET/POST/PATCH/PUT/DELETE/download) with `Result<T>`, `fold()`, and safe response parsing.
- Localized `ApiException` handling for Dio, socket, HTTP status codes, and 422 validation errors.
- Retry with exponential backoff on 503 via reusable `executeWithRetry`.
- Interceptor pipeline ready for auth, localization, app info, errors, and custom headers.
- Offline-first with Hive cache fallback when the network fails (`HomeRepositoryController`).
- Multi-layer caching: Hive, SharedPreferences, `CacheableMixin`, and `CachedNetworkImage`.

### Features & UX
- Paginated search with infinite scroll, debounced input, and skeleton load-more placeholders.
- Full cart flow: add, decrease, remove, clear, totals, swipe-to-delete, and Hive persistence.
- Advanced routing with `go_router`, route-level Bloc providers, redirects, and typed `extra` params.
- Responsive UI via `flutter_screenutil` and Figma design size (390×925).
- Adaptive layout: phone/tablet detection, keyboard-aware bottom nav, RTL, and embedded vs fullscreen cart.
- Pixel-perfect design system: Inter fonts, centralized colors, typography, and decorations.
- Reusable widget library: failure/empty states, toasts, bottom sheets, and form validators.

### Performance & Platform
- `AutomaticKeepAliveClientMixin`, debounced search, lazy DI, and cancelable Cubit/Bloc work on dispose.
- AR/EN localization with `easy_localization` and RTL support.
- Connectivity monitoring with online/offline UI feedback.
- Hive code generation, Equatable models, and DummyJSON REST API integration.
- Multi-platform project structure (Android, iOS, Web, desktop).
- Session/auth scaffolding with `SessionCubit` and protected-route redirect hooks.

### Flavors & Environment
- Dev/Prod flavors via `FlavorConfig` with separate entry points (`main_dev.dart`, `main_prod.dart`) and per-flavor base URLs.
- Flavor-aware utilities (e.g. connectivity checks against `FlavorConfig.instance.baseUrl`) and dev-only UI helpers (`WidgetEx.onDev`).

### Firebase & Notifications
- Firebase Core initialization scaffolded in dev/prod entry points (ready to plug in `firebase_options`).
- Firebase Cloud Messaging hooks prepared in `SessionCubit` (token delete on logout/account deletion).
- `NotificationEnum` for typed in-app/remote notification categories (general, order, promo, etc.).
- Toast-based in-app notifications via `toastification`; push/local notification layer ready to extend.

### Logging, Deep Links & Core Utilities (`lib/core/utls/`)
- Centralized `Logger` with colored debug output, log types (error, route, debug, success, notification), and auto-detected layers (API, repository, state, view, domain).
- `DeepLinkService` for validated deep-link routing with allowlist, safe post-frame navigation, and retry when context is not ready.
- Reusable core helpers: `debounce`, `execute_with_retry`, `connection_utils`, `parse_utls`, `file_utils`, `share_utls`, `date_picker`, card/expiry input formatters, and `utils.dart`.

### UI: Shimmers, Slivers & Overlays
- Skeleton/shimmer loading with `skeletonizer` (`SkeletonWidget`) on Home, Search, Product Details, and network images.
- Feature-specific shimmer screens: `HomeShimmer`, `SearchScreenShimmer`, `ProductDetailsShimmer`.
- Custom scroll UX with `CustomScrollView`, `SliverPersistentHeader`, `SliverPinnedDelegate`, and `SliverToBoxAdapter` sections on Home.
- `SuccessOverlay` for add-to-cart feedback using `OverlayEntry` (non-blocking, auto-dismiss).
- `DoublePressBackWidget` exit prompt via overlay instead of SnackBar.
- Pull-to-refresh, carousel, and `animate_do` section animations on Home.

## Technology Stack

| Category | Packages |
|----------|----------|
| **Core** | Flutter ^3.10.1, Dart, equatable, get_it, shared_preferences |
| **State & Routing** | flutter_bloc, go_router |
| **Networking & Storage** | dio, hive, hive_flutter, path_provider, connectivity_plus, internet_connection_checker_plus |
| **Localization** | easy_localization |
| **UI & Animations** | flutter_screenutil, animate_do, cached_network_image, skeletonizer, toastification, flutter_svg, carousel_slider, flutter_slidable |
| **Infrastructure (scaffolded)** | Firebase Core / FCM (entry-point hooks), deep links, overlays |

## Project Structure

Feature-first Clean Architecture:

```
lib/
├── core/                # Shared modules and utilities
│   ├── caching/         # SharedPreferences services
│   ├── database/        # Hive configuration and helpers
│   ├── di/              # Dependency injection (GetIt)
│   ├── services/        # Routing and external services
│   ├── utls/            # debounce, retry, deep links, formatters, file/share utils
│   ├── localization/    # AR/EN localization
│   └── logging/         # Logger (layer detection, route/error/notification logs)
├── config/              # Flavors, themes, constants, styles
├── features/            # Feature modules
│   ├── cart/            # presentation, data
│   ├── home/            # presentation, domain, data (3-layer)
│   ├── product_details/ # presentation, data
│   └── search/          # presentation, data
├── shared/              # Dio client, widgets (shimmer, overlay, slivers), extensions, mixins
└── main_dev.dart        # Dev entry point (Firebase scaffolded; main_prod.dart for prod)
```

## Getting Started

### Prerequisites

- Flutter SDK (compatible with Dart ^3.10.1)
- Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```bash
   cd test_eccomarce
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the code generator (Hive adapters):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. Run the application:
   ```bash
   flutter run -t lib/main_dev.dart
   ```

### Build Commands

```bash
# Dev
flutter run -t lib/main_dev.dart --flavor=dev

# Prod
flutter run -t lib/main_prod.dart --flavor=prod

# APK (prod)
flutter build apk --split-per-abi -t lib/main_prod.dart --flavor=prod

# App Bundle (prod)
flutter build appbundle -t lib/main_prod.dart --flavor=prod
```

## Development

- **Format Code**: `dart format .`
- **Analyze Code**: `flutter analyze`
- **Run Tests**: `flutter test`
