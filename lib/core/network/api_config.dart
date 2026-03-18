abstract final class ApiConfig {
  // For real device: use your PC's local IP (phone must be on same Wi-Fi)
  // For Android emulator: use 10.0.2.2
  // For iOS simulator: use localhost
  static const String localUrl = 'http://192.168.100.116:3000/api/v1';
  static const String prodBaseUrl = 'https://api.rededge.com/api/v1';

  // Google Maps / Places API key — replace with your actual key
  static const String googleMapsApiKey = 'AIzaSyCHu2P393o5K6fOd6LI_T62YQc5OnhvR1A';

  static String get baseUrl {
    const env = String.fromEnvironment('ENV', defaultValue: 'local');
    return switch (env) {
      'prod' => prodBaseUrl,
      _ => localUrl,
    };
  }
}
