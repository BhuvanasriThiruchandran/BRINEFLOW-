import 'package:flutter/foundation.dart';

class ApiConfig {
  static const _configuredBaseUrl =
      String.fromEnvironment('BRINEFLOW_API_BASE_URL');

  static String get baseUrl {
    if (_configuredBaseUrl.isNotEmpty) {
      return _configuredBaseUrl;
    }

    if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
      return 'http://10.0.2.2:5000';
    }

    return 'http://127.0.0.1:5000';
  }
}
