import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Owner styles the app here.
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
  );
}
