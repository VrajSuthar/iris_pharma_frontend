import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'hive_boxes.dart';

/// The only place that initialises Hive and opens boxes.
/// Local sources get their box through [box].
abstract final class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    // Register type adapters here, before opening boxes.
    for (final name in HiveBoxes.all) {
      await Hive.openBox<dynamic>(name);
    }
  }

  static Box<dynamic> box(String name) => Hive.box<dynamic>(name);

  /// Clears boxes that hold user-specific data. Call on logout.
  static Future<void> clearUserData() async {
    await box(HiveBoxes.cart).clear();
    await box(HiveBoxes.wishlist).clear();
    await box(HiveBoxes.session).clear();
  }
}
