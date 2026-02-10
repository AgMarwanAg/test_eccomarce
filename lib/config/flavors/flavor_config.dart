/// An enumeration that defines the available app flavors.
enum Flavor {
  dev, // Development flavor
  prod, // Production flavor
}

/// A configuration class for managing app flavors and their corresponding settings.
class FlavorConfig {
  final Flavor flavor; // The current flavor of the app
  final String baseUrl; // The base URL for the app's API

  // Singleton instance of FlavorConfig
  static late FlavorConfig _instance;

  /// Private constructor to prevent external instantiation.
  FlavorConfig._internal({required this.flavor, required this.baseUrl});

  /// Factory method to initialize the flavor configuration.
  ///
  /// Parameters:
  /// - [flavor]: The flavor to set for the application (dev or prod).
  /// - [baseUrl]: The base URL to use for API calls based on the flavor.
  ///
  /// Returns:
  /// - A [FlavorConfig] instance configured with the provided flavor and base URL.
  factory FlavorConfig({required Flavor flavor, required String baseUrl}) {
    _instance = FlavorConfig._internal(flavor: flavor, baseUrl: baseUrl);
    return _instance;
  }

  /// Getter to access the singleton instance of FlavorConfig.
  ///
  /// Returns:
  /// - The current instance of [FlavorConfig].
  static FlavorConfig get instance => _instance;

  /// Utility method to check if the current flavor is production.
  ///
  /// Returns:
  /// - `true` if the flavor is [Flavor.prod], otherwise `false`.
  static bool isProd() => _instance.flavor == Flavor.prod;

  /// Utility method to check if the current flavor is development.
  ///
  /// Returns:
  /// - `true` if the flavor is [Flavor.dev], otherwise `false`.
  static bool isDev() => _instance.flavor == Flavor.dev;
}
