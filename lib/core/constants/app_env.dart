/// Build-time environment values. Pass with `--dart-define=BASE_URL=https://...`.
abstract final class AppEnv {
  static const baseUrl = String.fromEnvironment('BASE_URL');
}
