# Mixin Module

## Overview

The Mixin module provides reusable functionality that can be mixed into classes to add common capabilities like caching, list management, and cancellable operations. These mixins follow the DRY (Don't Repeat Yourself) principle and provide consistent patterns across the application.

## Available Mixins

### 1. CacheableMixin
### 2. CacheableListMixin
### 3. CancelableCubitMixin

## CacheableMixin

Provides caching functionality for individual model instances using SharedPreferences.

### Features

- 💾 Save/load single objects to/from cache
- 🔄 JSON serialization/deserialization
- ⚙️ Configurable cache keys
- 🧹 Cache clearing functionality
- 🔒 Type-safe operations

### Implementation Requirements

Classes using this mixin must implement:

```dart
abstract class CacheableMixin<T> {
  // Convert object to Map for JSON serialization
  Map<String, dynamic> toMap();
  
  // Create instance from cached JSON data
  T fromCacheJson(Map<String, dynamic> json);
  
  // Provide default cache key
  String getCacheKey();
}
```

### Usage Example

```dart
class UserModel extends Equatable with CacheableMixin<UserModel> {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
  
  // Factory constructor for API responses
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
    );
  }
  
  // Required: Convert to Map for caching
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
  
  // Required: Create from cached data
  @override
  UserModel fromCacheJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
    );
  }
  
  // Required: Provide cache key
  @override
  String getCacheKey() => 'current_user';
  
  @override
  List<Object?> get props => [id, name, email, avatar];
}
```

### Basic Operations

```dart
// Create user instance
final user = UserModel(
  id: 1,
  name: 'Ahmed Ali',
  email: 'ahmed@example.com',
);

// Save to cache
await user.saveToCache(); // Uses default key
await user.saveToCache('user_profile'); // Custom key

// Load from cache
UserModel? cachedUser = CacheableMixin.getCachedInstance<UserModel>(
  'current_user',
  (json) => UserModel().fromCacheJson(json),
);

// Check if cached data exists
if (CacheableMixin.hasCachedData('current_user')) {
  print('User data is cached');
}

// Clear cache
await user.clearCache();
await CacheableMixin.clear('current_user');
```

### Advanced Usage

```dart
class SettingsModel with CacheableMixin<SettingsModel> {
  final bool darkMode;
  final String language;
  final bool notifications;
  
  const SettingsModel({
    required this.darkMode,
    required this.language,
    required this.notifications,
  });
  
  // Static method to get cached settings with defaults
  static SettingsModel getSettings() {
    return getCachedInstance<SettingsModel>(
      'app_settings',
      (json) => SettingsModel._fromCache(json),
    ) ?? SettingsModel.defaults();
  }
  
  static SettingsModel defaults() {
    return SettingsModel(
      darkMode: false,
      language: 'en',
      notifications: true,
    );
  }
  
  factory SettingsModel._fromCache(Map<String, dynamic> json) {
    return SettingsModel(
      darkMode: json['darkMode'] as bool? ?? false,
      language: json['language'] as String? ?? 'en',
      notifications: json['notifications'] as bool? ?? true,
    );
  }
  
  @override
  Map<String, dynamic> toMap() => {
    'darkMode': darkMode,
    'language': language,
    'notifications': notifications,
  };
  
  @override
  SettingsModel fromCacheJson(Map<String, dynamic> json) {
    return SettingsModel._fromCache(json);
  }
  
  @override
  String getCacheKey() => 'app_settings';
  
  // Update settings and save to cache
  Future<SettingsModel> updateAndSave({
    bool? darkMode,
    String? language,
    bool? notifications,
  }) async {
    final updated = SettingsModel(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      notifications: notifications ?? this.notifications,
    );
    
    await updated.saveToCache();
    return updated;
  }
}
```

## CacheableListMixin

Provides caching functionality for lists of model instances.

### Features

- 📝 Save/load lists to/from cache
- 🔄 Batch operations for multiple items
- ⚙️ Type-safe list operations
- 🧹 List-specific cache management

### Usage Example

```dart
class ProductModel with CacheableListMixin<ProductModel> {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
    };
  }
  
  @override
  ProductModel fromCacheJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
    );
  }
}
```

### List Operations

```dart
// Sample products
final products = [
  ProductModel(id: 1, name: 'Laptop', price: 999.99, imageUrl: 'laptop.jpg'),
  ProductModel(id: 2, name: 'Mouse', price: 29.99, imageUrl: 'mouse.jpg'),
];

// Save list to cache
await CacheableListMixin.saveList<ProductModel>(
  'featured_products',
  products,
  (product) => product.toMap(),
);

// Load list from cache
List<ProductModel>? cachedProducts = CacheableListMixin.getList<ProductModel>(
  'featured_products',
  (json) => ProductModel().fromCacheJson(json),
);

// Clear cached list
await CacheableListMixin.clearList('featured_products');
```

### Repository Integration

```dart
class ProductsRepository {
  static const String _cacheKey = 'products_cache';
  
  Future<List<ProductModel>> getProducts({bool forceRefresh = false}) async {
    // Try cache first unless force refresh
    if (!forceRefresh) {
      final cachedProducts = CacheableListMixin.getList<ProductModel>(
        _cacheKey,
        (json) => ProductModel().fromCacheJson(json),
      );
      
      if (cachedProducts != null && cachedProducts.isNotEmpty) {
        return cachedProducts;
      }
    }
    
    // Fetch from API
    final apiProducts = await _apiService.getProducts();
    
    // Cache the results
    await CacheableListMixin.saveList<ProductModel>(
      _cacheKey,
      apiProducts,
      (product) => product.toMap(),
    );
    
    return apiProducts;
  }
  
  Future<void> clearProductsCache() async {
    await CacheableListMixin.clearList(_cacheKey);
  }
}
```

## CancelableCubitMixin

Provides cancellation functionality for Cubit operations to prevent memory leaks and unnecessary API calls.

### Features

- ❌ Cancel ongoing operations
- 🛡️ Prevent memory leaks
- ⚡ Automatic cleanup on disposal
- 🔄 Support for multiple operations

### Usage Example

```dart
class ProductsCubit extends Cubit<ProductsState> with CancelableCubitMixin<ProductsState> {
  final ProductsRepository _repository;
  
  ProductsCubit(this._repository) : super(ProductsInitial());
  
  Future<void> loadProducts() async {
    emit(ProductsLoading());
    
    // Use runCancellable for operations that should be cancellable
    final products = await runCancellable<List<ProductModel>>(
      _repository.getProducts(),
      onCancel: () {
        print('Products loading was cancelled');
      },
    );
    
    // Check if operation was cancelled
    if (products != null) {
      emit(ProductsSuccess(products));
    }
    // If cancelled, products will be null and no state change occurs
  }
  
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(ProductsInitial());
      return;
    }
    
    emit(ProductsLoading());
    
    // This will automatically cancel the previous search
    final results = await runCancellable<List<ProductModel>>(
      _repository.searchProducts(query),
    );
    
    if (results != null) {
      emit(ProductsSuccess(results));
    }
  }
  
  // Manual cancellation (optional)
  void cancelCurrentOperation() {
    // The mixin handles cancellation automatically,
    // but you can trigger it manually if needed
  }
}
```

### Advanced Cancellation

```dart
class AdvancedCubit extends Cubit<MyState> with CancelableCubitMixin<MyState> {
  
  Future<void> performLongOperation() async {
    emit(LoadingState());
    
    try {
      // Multiple cancellable operations
      final step1 = await runCancellable(
        _performStep1(),
        onCancel: () => print('Step 1 cancelled'),
      );
      
      if (step1 == null) return; // Operation was cancelled
      
      final step2 = await runCancellable(
        _performStep2(step1),
        onCancel: () => print('Step 2 cancelled'),
      );
      
      if (step2 == null) return; // Operation was cancelled
      
      emit(SuccessState(step2));
      
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  Future<String> _performStep1() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Step 1 complete';
  }
  
  Future<String> _performStep2(String input) async {
    await Future.delayed(Duration(seconds: 3));
    return 'Step 2 complete with: $input';
  }
}
```

## Best Practices

### 1. Use CacheableMixin for Single Objects

```dart
// ✅ Good - User profile, settings, current session
class UserProfile with CacheableMixin<UserProfile> {
  // Implementation
}

// ❌ Bad - Don't use for collections
class ProductsList with CacheableMixin<ProductsList> {
  final List<Product> products; // Use CacheableListMixin instead
}
```

### 2. Use CacheableListMixin for Collections

```dart
// ✅ Good - Product lists, search results, categories
class Product with CacheableListMixin<Product> {
  // Save/load lists of products
}

// ✅ Good - Repository pattern
class ProductsRepo {
  Future<List<Product>> getProducts() async {
    final cached = CacheableListMixin.getList<Product>(...);
    if (cached != null) return cached;
    
    final fresh = await api.getProducts();
    await CacheableListMixin.saveList(...);
    return fresh;
  }
}
```

### 3. Use CancelableCubitMixin for API Operations

```dart
// ✅ Good - Search, data loading, user actions
class SearchCubit extends Cubit<SearchState> with CancelableCubitMixin {
  Future<void> search(String query) async {
    final results = await runCancellable(
      _api.search(query),
    );
    if (results != null) {
      emit(SearchSuccess(results));
    }
  }
}

// ❌ Bad - Don't use for simple state changes
class CounterCubit extends Cubit<int> with CancelableCubitMixin {
  void increment() {
    emit(state + 1); // No need for cancellation here
  }
}
```

### 4. Implement Required Methods Correctly

```dart
// ✅ Good - Proper implementation
class MyModel with CacheableMixin<MyModel> {
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      // Include all necessary fields
    };
  }
  
  @override
  MyModel fromCacheJson(Map<String, dynamic> json) {
    return MyModel(
      id: json['id'] as int,
      name: json['name'] as String,
      // Handle potential null values
    );
  }
  
  @override
  String getCacheKey() => 'my_model'; // Unique key
}
```

### 5. Handle Cache Errors Gracefully

```dart
class SafeCacheModel with CacheableMixin<SafeCacheModel> {
  static SafeCacheModel? getSafely(String key) {
    try {
      return CacheableMixin.getCachedInstance<SafeCacheModel>(
        key,
        (json) => SafeCacheModel().fromCacheJson(json),
      );
    } catch (e) {
      Logger.error('Cache retrieval failed: $e');
      return null;
    }
  }
  
  Future<bool> saveSafely() async {
    try {
      return await saveToCache();
    } catch (e) {
      Logger.error('Cache save failed: $e');
      return false;
    }
  }
}
```

## Performance Considerations

1. **Cache Size**: Monitor cache size for large lists
2. **Serialization Cost**: Complex objects may be expensive to serialize
3. **Memory Usage**: Cached data uses device storage
4. **Cancellation Overhead**: Minimal overhead for cancellable operations

## Common Patterns

### Cache-First Data Loading

```dart
Future<T> loadWithCache<T>(
  String cacheKey,
  Future<T> Function() fetchFromApi,
  bool Function(T) isValid,
) async {
  // Try cache first
  final cached = getCachedData<T>(cacheKey);
  if (cached != null && isValid(cached)) {
    return cached;
  }
  
  // Fetch fresh data
  final fresh = await fetchFromApi();
  await saveTocache(cacheKey, fresh);
  return fresh;
}
```

### Search with Debouncing and Cancellation

```dart
class SearchCubit extends Cubit<SearchState> with CancelableCubitMixin {
  Timer? _debounceTimer;
  
  void search(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 300), () {
      _performSearch(query);
    });
  }
  
  Future<void> _performSearch(String query) async {
    emit(SearchLoading());
    
    final results = await runCancellable(
      _repository.search(query),
    );
    
    if (results != null) {
      emit(SearchSuccess(results));
    }
  }
}
```

These mixins provide essential functionality for modern Flutter applications, ensuring efficient caching, proper resource management, and responsive user interfaces.