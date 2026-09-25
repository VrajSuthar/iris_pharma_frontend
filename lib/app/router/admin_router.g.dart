// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dashboard router. Add the staff-only guard with the admin auth work.

@ProviderFor(adminRouter)
final adminRouterProvider = AdminRouterProvider._();

/// Dashboard router. Add the staff-only guard with the admin auth work.

final class AdminRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Dashboard router. Add the staff-only guard with the admin auth work.
  AdminRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return adminRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$adminRouterHash() => r'26026ecc01370e4b2ddae9b38a0a4c82791f92b1';
