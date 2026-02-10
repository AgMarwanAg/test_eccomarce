# DioClient Module

## Overview

The DioClient module provides a robust HTTP client wrapper around the Dio package, offering standardized API communication with built-in error handling, interceptors, and the Result pattern for clean success/failure handling.

## Features

- 🌐 RESTful API support (GET, POST, PUT, PATCH, DELETE)
- 💾 Built-in response caching with flexible cache control
- 🔄 Result pattern for error handling
- 🔌 Custom interceptors for authentication, logging, and localization
- ⚡ Configurable timeouts and retry mechanisms
- 🎯 Mock support for testing
- 📝 Comprehensive error handling with ApiException

## Core Components

### DioClient

Main HTTP client class that wraps Dio functionality:

```dart
class DioClient with DioCacheMixin {
  // HTTP Methods
  Future<Result> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? option,
    bool useCache = false,
    bool forceRefresh = false,
    Duration? cacheDuration,
  })
  Future<Result> post(String endpoint, {...})
  Future<Result> put(String endpoint, {...})
  Future<Result> patch(String endpoint, {...})
  Future<Result> delete(String endpoint, {...})
  
  // Mock support
  Future<Result> mockGet(Object fakeData, {...})
  
  // Cache management
  Future<void> clearCache()
  Future<void> deleteCacheByKey(String key)
  Future<bool> cacheExists(String key)
}
```

### Result Pattern

A generic class for handling success/failure responses:

```dart
class Result<T> {
  final T? data;
  final ApiException? exception;
  
  // Factory constructors
  factory Result.success(T data)
  factory Result.failure(ApiException exception)
  
  // Utility methods
  bool get isSuccess
  bool get isFailure
  R fold<R>({...})
}
```

### ApiException

Custom exception class for API errors with detailed error information.

## Usage Examples

### Basic GET Request

```dart
// In your API service
class ProductsApi {
  final DioClient _dioClient;
  
  ProductsApi(this._dioClient);
  
  // Simple GET request (no cache)
  Future<Result<List<Product>>> getProducts() async {
    final result = await _dioClient.get('/products');
    
    return result.fold(
      onSuccess: (data) {
        final products = (data['data'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
        return Result.success(products);
      },
      onFailure: (exception) => Result.failure(exception),
    );
  }
  
  // GET request with cache enabled
  Future<Result<List<Product>>> getCachedProducts() async {
    final result = await _dioClient.get(
      '/products',
      useCache: true,
      cacheDuration: Duration(hours: 1),
    );
    
    return result.fold(
      onSuccess: (data) {
        final products = (data['data'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
        return Result.success(products);
      },
      onFailure: (exception) => Result.failure(exception),
    );
  }
}
```

### POST Request with Data

```dart
Future<Result<User>> createUser(Map<String, dynamic> userData) async {
  final result = await _dioClient.post(
    '/users',
    data: userData,
  );
  
  return result.fold(
    onSuccess: (data) {
      final user = User.fromJson(data['data']);
      return Result.success(user);
    },
    onFailure: (exception) => Result.failure(exception),
  );
}
```

### Using in Repository

```dart
class ProductsRepoImpl implements ProductsRepo {
  final ProductsApi _api;
  
  ProductsRepoImpl(this._api);
  
  @override
  Future<Result<List<Product>>> getProducts() {
    return _api.getProducts();
  }
}
```

### Using in Cubit/BLoC

```dart
class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _repo;
  
  ProductsCubit(this._repo) : super(ProductsInitial());
  
  Future<void> loadProducts() async {
    emit(ProductsLoading());
    
    final result = await _repo.getProducts();
    
    result.fold(
      onSuccess: (products) => emit(ProductsSuccess(products)),
      onFailure: (error) => emit(ProductsError(error.message)),
    );
  }
}
```

### Error Handling

```dart
Future<void> handleApiCall() async {
  final result = await _dioClient.get('/endpoint');
  
  if (result.isSuccess) {
    // Handle success
    final data = result.data;
    print('Success: $data');
  } else if (result.isFailure) {
    // Handle error
    final error = result.exception!;
    print('Error: ${error.message}');
    
    // Check specific error types
    if (error.statusCode == 401) {
      // Handle unauthorized
    } else if (error.statusCode == 500) {
      // Handle server error
    }
  }
}
```

### Mock Testing

```dart
// For testing purposes
Future<Result> mockApiCall() async {
  final fakeData = {'message': 'Success', 'data': []};
  
  return await _dioClient.mockGet(
    fakeData,
    duration: Duration(seconds: 1),
    isError: false,
  );
}
```

## Configuration

### Base Configuration

```dart
DioClient() {
  BaseOptions options = BaseOptions(
    baseUrl: "${FlavorConfig.instance.baseUrl}/api",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
}
```

### Interceptors

The DioClient automatically includes these interceptors:

- **CacheInterceptor**: Handles HTTP response caching (via DioCacheMixin)
- **LoggingInterceptor**: Logs requests and responses
- **AuthInterceptor**: Adds authentication tokens
- **LocalizationInterceptor**: Adds language headers
- **AppInfoInterceptor**: Adds app version info
- **ErrorInterceptor**: Handles common errors

### Cache Configuration

The DioClient includes built-in caching through the `DioCacheMixin`. The cache is automatically initialized with these default settings:

- **Store**: MemCacheStore (in-memory, volatile)
- **Policy**: CachePolicy.request (respects HTTP directives)
- **Network Failure Fallback**: Enabled
- **Error Code Fallback**: 500, 502, 503
- **Max Stale**: 1 hour
- **POST Caching**: Disabled

#### Using Cache in Requests

The DioClient provides a simple `useCache` parameter for GET requests:

```dart
// No cache (default behavior)
final result = await _dioClient.get('/products');

// Enable cache with default settings (1 hour)
final result = await _dioClient.get(
  '/products',
  useCache: true,
);

// Custom cache duration
final result = await _dioClient.get(
  '/products',
  useCache: true,
  cacheDuration: Duration(hours: 2),
);

// Force refresh (bypass cache and fetch fresh data)
final result = await _dioClient.get(
  '/products',
  useCache: true,
  forceRefresh: true,
);
```

#### Advanced Cache Options

For advanced cache control, you can use `buildCacheOptions` directly:

```dart
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

// Force cache (use only cached data)
final result = await _dioClient.get(
  '/products',
  option: _dioClient.buildCacheOptions(
    policy: CachePolicy.forceCache,
  ),
);

// No cache for specific request
final result = await _dioClient.get(
  '/products',
  option: _dioClient.buildCacheOptions(
    policy: CachePolicy.noCache,
  ),
);
```

#### Cache Policies

- **CachePolicy.request**: (Default) Respects HTTP cache headers
- **CachePolicy.refresh**: Always fetches fresh data, updates cache
- **CachePolicy.forceCache**: Only uses cached data, fails if no cache
- **CachePolicy.noCache**: Never uses cache, never stores response

#### Managing Cache

```dart
// In your DioClient instance
final dioClient = DioClient();

// Clear all cache
await dioClient.clearCache();

// Delete specific cache entry
await dioClient.deleteCacheByKey('specific-key');

// Check if cache exists
final exists = await dioClient.cacheExists('specific-key');
```

#### Persistent Cache Storage

The default implementation uses `MemCacheStore` (in-memory). For persistent caching across app restarts, you can modify `dio_cache_mixin.dart` to use other stores:

```dart
// Option 1: File-based cache (add http_cache_file_store package)
_cacheStore = FileCacheStore(await getTemporaryDirectory());

// Option 2: Hive-based cache (add http_cache_hive_store package)
_cacheStore = HiveCacheStore(await getTemporaryDirectory());

// Option 3: Sembast-based cache (add http_cache_sembast_store package)
_cacheStore = SembastCacheStore(await getTemporaryDirectory());
```

## Dependency Injection

```dart
// In locator.dart
sl.registerSingleton<DioClient>(DioClient());
sl.registerLazySingleton<ProductsApi>(() => ProductsApi(sl<DioClient>()));
```

## Best Practices

### 1. Always Use Result Pattern

```dart
// ✅ Good
Future<Result<List<Product>>> getProducts() async {
  final result = await _dioClient.get('/products');
  return result.fold(
    onSuccess: (data) => Result.success(parseProducts(data)),
    onFailure: (error) => Result.failure(error),
  );
}

// ❌ Bad
Future<List<Product>> getProducts() async {
  final response = await _dioClient.get('/products');
  return parseProducts(response.data); // No error handling
}
```

### 2. Handle Errors Gracefully

```dart
result.fold(
  onSuccess: (data) {
    // Update UI with success
    emit(SuccessState(data));
  },
  onFailure: (error) {
    // Show user-friendly error
    emit(ErrorState(error.userFriendlyMessage));
    
    // Log technical details
    Logger.error('API Error: ${error.toString()}');
  },
);
```

### 3. Use Type-Safe Parsing

```dart
Future<Result<Product>> getProduct(int id) async {
  return Result.handleApiResponse<Product>(
    _dioClient.get('/products/$id'),
    (data) => Product.fromJson(data['data']),
    exceptionMessage: 'Failed to load product',
  );
}
```

### 4. Use Caching for Performance

```dart
// Cache static or infrequently changing data
Future<Result<List<Category>>> getCategories() async {
  return await _dioClient.get(
    '/categories',
    useCache: true,
    cacheDuration: Duration(hours: 24),
  );
}

// Don't cache dynamic data
Future<Result<Order>> createOrder(OrderData data) async {
  return await _dioClient.post('/orders', data: data.toJson());
}
```

### 5. Implement Retry Logic

```dart
Future<Result<T>> apiCallWithRetry<T>(
  Future<Result<T>> Function() apiCall,
  {int maxRetries = 3}
) async {
  for (int attempt = 0; attempt < maxRetries; attempt++) {
    final result = await apiCall();
    
    if (result.isSuccess || attempt == maxRetries - 1) {
      return result;
    }
    
    await Future.delayed(Duration(seconds: attempt + 1));
  }
  
  return Result.failure(ApiException(message: 'Max retries exceeded'));
}
```

## Error Types

### Network Errors
- Connection timeout
- Socket exceptions
- No internet connection

### HTTP Errors
- 4xx Client errors (400, 401, 403, 404, etc.)
- 5xx Server errors (500, 502, 503, etc.)

### Parsing Errors
- JSON decode errors
- Type conversion errors
- Missing required fields

## Testing

### Unit Testing API Services

```dart
class MockDioClient extends Mock implements DioClient {}

void main() {
  group('ProductsApi', () {
    late ProductsApi api;
    late MockDioClient mockDioClient;
    
    setUp(() {
      mockDioClient = MockDioClient();
      api = ProductsApi(mockDioClient);
    });
    
    test('getProducts returns success result', () async {
      // Arrange
      final responseData = {'data': [{'id': 1, 'name': 'Product 1'}]};
      when(() => mockDioClient.get('/products'))
          .thenAnswer((_) async => Result.success(responseData));
      
      // Act
      final result = await api.getProducts();
      
      // Assert
      expect(result.isSuccess, true);
      expect(result.data!.length, 1);
    });
  });
}
```

## Migration Guide

### From Direct Dio Usage

```dart
// Before
final response = await dio.get('/products');
final products = (response.data['data'] as List)
    .map((json) => Product.fromJson(json))
    .toList();

// After
final result = await _dioClient.get('/products');
final products = result.fold(
  onSuccess: (data) => (data['data'] as List)
      .map((json) => Product.fromJson(json))
      .toList(),
  onFailure: (error) => <Product>[],
);
```

## Common Issues

### Issue: Timeout Errors
**Solution**: Increase timeout or check network connectivity

```dart
// Custom timeout for specific requests
final result = await _dioClient.get(
  '/heavy-endpoint',
  option: Options(receiveTimeout: Duration(minutes: 2)),
);
```

### Issue: Authentication Errors
**Solution**: Ensure AuthInterceptor is properly configured

### Issue: Parsing Errors
**Solution**: Use Result.handleApiResponse for safe parsing

## Performance Tips

1. **Use connection pooling**: Dio automatically handles this
2. **Implement request cancellation**: Use CancelToken for long requests
3. **Cache responses**: Implement caching at the repository level
4. **Compress requests**: Enable gzip compression
5. **Minimize JSON payload**: Use selective field queries when possible

This module provides a robust foundation for all HTTP communication in the InCart application, ensuring consistent error handling and maintainable API integration patterns.