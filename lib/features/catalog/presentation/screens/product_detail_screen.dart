import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/product_detail/product_detail_desktop.dart';
import '../widgets/product_detail/product_detail_mobile.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => ProductDetailMobile(productId: productId),
        desktop: (_) => ProductDetailDesktop(productId: productId),
      ),
    );
  }
}
