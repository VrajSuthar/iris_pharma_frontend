import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  ({bool notifications, bool darkMode}) build() =>
      (notifications: true, darkMode: false);

  void toggleNotifications() =>
      state = (notifications: !state.notifications, darkMode: state.darkMode);

  void toggleDarkMode() =>
      state = (notifications: state.notifications, darkMode: !state.darkMode);
}
