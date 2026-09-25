/// Every route path. Screens and providers use these, never string literals.
abstract final class RoutePaths {
  static const home = '/';
  static const categories = '/categories';
  static const cart = '/cart';
  static const profile = '/profile';

  static const search = '/search';

  static const productIdParam = 'productId';
  static const productDetail = '/products/:$productIdParam';
  static String productDetailOf(String id) => '/products/$id';
}

abstract final class AdminRoutePaths {
  static const dashboard = '/';
}
