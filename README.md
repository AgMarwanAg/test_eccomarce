# Test Ecommerce

A modern, offline-first Flutter e-commerce application demonstrating a scalable architecture and premium design.

## Features

- **Home**: Featured products, new arrivals, and special collections.
- **Search**: Advanced product search with filters.
- **Product Details**: Comprehensive product information with image galleries.
- **Cart**: Complete shopping cart management with quantity controls and total calculation.
- **Offline First**: Seamless experience with local caching using Hive.

## Technology Stack

### Core
- **Flutter**: ^3.10.1
- **Dart**: Programming language

### State Management & Architecture
- **flutter_bloc**: State management using BLoC pattern.
- **get_it**: Dependency injection service locator.
- **equatable**: Value equality for Dart objects.
- **clean_architecture**: Project structure organized by features (presentation, domain, data).

### Navigation
- **go_router**: Declarative routing package for Flutter.

### Networking & Data
- **dio**: Powerful HTTP client for Dart.
- **hive**: Lightweight and blazing fast key-value database.
- **shared_preferences**: Persistent storage for simple data.
- **internet_connection_checker_plus**: Internet connection monitoring.
- **connectivity_plus**: Network connectivity status.

### UI & Animations
- **flutter_screenutil**: Screen adaptation for various device sizes.
- **animate_do**: Beautiful animations inspired by Animate.css.
- **cached_network_image**: Image caching for smoother scrolling.
- **skeletonizer**: Skeleton loading animations.
- **toastification**: Customizable toast notifications.
- **flutter_svg**: SVG rendering support.
- **carousel_slider**: Image carousel slider.
- **flutter_slidable**: Slidable list items.

## Project Structure

The project follows a feature-first Clean Architecture approach:

```
lib/
├── core/                # Shared modules and utilities
│   ├── caching/         # Local storage implementation
│   ├── database/        # Database configurations
│   ├── di/              # Dependency injection setup
│   ├── services/        # External services
│   ├── utls/            # Helper functions and constants
│   ├── localization/    # App localization
│   ├── logging/         # Logger configuration
│   └── ...
├── features/            # Feature-specific code
│   ├── cart/
│   ├── home/
│   ├── product_details/
│   └── search/
└── main.dart            # Application entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (Ensure you have a compatible version installed)
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

4. Run the code generator (for Hive, JSON serialization, etc.):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. Run the application:
   ```bash
   flutter run -t lib/main_dev.dar
   ```

## Development

- **Run Tests**: `flutter test`
- **Format Code**: `dart format .`
- **Analyze Code**: `flutter analyze`
