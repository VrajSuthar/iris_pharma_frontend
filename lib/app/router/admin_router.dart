import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../admin/features/dashboard/presentation/screens/admin_dashboard_screen.dart';
import '../../core/logging/router_logger.dart';
import 'route_paths.dart';

part 'admin_router.g.dart';

/// Dashboard router. Add the staff-only guard with the admin auth work.
@Riverpod(keepAlive: true)
GoRouter adminRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: AdminRoutePaths.dashboard,
    routes: [
      GoRoute(
        path: AdminRoutePaths.dashboard,
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );
  logRouterChanges(router, ref);
  return router;
}
