import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Picks a layout by available width. [tablet] falls back to [mobile],
/// and [desktop] falls back to [tablet].
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final builder = switch (Breakpoints.fromWidth(constraints.maxWidth)) {
          ScreenSize.desktop => desktop ?? tablet ?? mobile,
          ScreenSize.tablet => tablet ?? mobile,
          ScreenSize.mobile => mobile,
        };
        return builder(context);
      },
    );
  }
}
