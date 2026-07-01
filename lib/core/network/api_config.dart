abstract final class ApiConfig {
  // For real device: use your PC's local IP (phone must be on same Wi-Fi)
  // For Android emulator: use 10.0.2.2
  // For iOS simulator: use localhost
  static const String localUrl = 'https://jellyfish-app-fs8p4.ondigitalocean.app/api/v1';
  static const String prodBaseUrl = 'https://jellyfish-app-fs8p4.ondigitalocean.app/api/v1';

  // Web dashboard for adding/removing machines and uploading Excel checklist sheets
  static const String checklistManagerUrl =
      'https://jellyfish-app-fs8p4.ondigitalocean.app/checklist-manager/';

  // Google Maps / Places API key — replace with your actual key
  static const String googleMapsApiKey =
      'AIzaSyCHu2P393o5K6fOd6LI_T62YQc5OnhvR1A';

  static String get baseUrl {
    const env = String.fromEnvironment('ENV', defaultValue: 'local');
    return switch (env) {
      'prod' => prodBaseUrl,
      _ => localUrl,
    };
  }
}
