/// The only allowed log tags. Add a tag here before using it.
///
/// System tags (written by the core, do not use in features):
///   [http], [riverpod], [router], [storage], [error]
/// Feature tags (one per feature folder):
///   [auth], [home], [catalog], [search], [cart], [checkout], [orders],
///   [profile], [admin]
abstract final class LogTag {
  static const app = 'app';

  // System
  static const http = 'http';
  static const riverpod = 'riverpod';
  static const router = 'router';
  static const storage = 'storage';
  static const error = 'error';

  // Features
  static const auth = 'auth';
  static const home = 'home';
  static const catalog = 'catalog';
  static const search = 'search';
  static const cart = 'cart';
  static const checkout = 'checkout';
  static const orders = 'orders';
  static const profile = 'profile';
  static const admin = 'admin';
}
