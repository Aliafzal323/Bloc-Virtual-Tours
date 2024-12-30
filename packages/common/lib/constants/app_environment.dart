import 'package:common/http/http_client.dart';

enum AppEnvironment {
  prod(
    config: HttpClientConfig(
      baseUrl: 'https://dummyjson.com/',
    ),
  ),
  dev(
    config: HttpClientConfig(
      baseUrl: 'https://dummyjson.com/',
      enableLogs: true,
    ),
  );

  const AppEnvironment({
    required this.config,
  });

  final HttpClientConfig config;

  bool get isProd => this == AppEnvironment.prod;
  bool get isDev => this == AppEnvironment.dev;

  static AppEnvironment _current = AppEnvironment.dev;
  static AppEnvironment get current => _current;
  static set current(AppEnvironment env) => _current = env;
}
