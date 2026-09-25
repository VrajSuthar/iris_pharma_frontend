import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/cart/cart_desktop.dart';
import '../widgets/cart/cart_mobile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const CartMobile(),
        desktop: (_) => const CartDesktop(),
      ),
    );
  }
}
