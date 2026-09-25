/// Every route path. Screens and providers use these, never string literals.
abstract final class RoutePaths {
  static const splash = '/';
  static const splashIntro = '/splash-intro';

  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  static const home = '/home';
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
