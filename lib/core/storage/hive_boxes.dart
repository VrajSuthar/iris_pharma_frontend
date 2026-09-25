/// Names of every Hive box. Add a name here before opening a new box.
abstract final class HiveBoxes {
  static const settings = 'settings';
  static const cart = 'cart';
  static const wishlist = 'wishlist';
  static const recentSearches = 'recent_searches';
  static const catalogCache = 'catalog_cache';
  static const session = 'session';

  static const all = [
    settings,
    cart,
    wishlist,
    recentSearches,
    catalogCache,
    session,
  ];
}
