/// Every endpoint path. Adjust to match the backend once it is chosen.
abstract final class ApiEndpoints {
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const refresh = '/auth/refresh';

  static const products = '/products';
  static String product(String id) => '/products/$id';
  static const categories = '/categories';
  static const brands = '/brands';

  static const orders = '/orders';
}
