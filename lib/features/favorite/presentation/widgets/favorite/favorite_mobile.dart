import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/common_product_card.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../../core/widgets/common_top_bar_main.dart';

class FavoriteMobile extends StatelessWidget {
  const FavoriteMobile({super.key});

  static const _products = <({String name, String price})>[
    (name: 'Hydrating Facial Serum', price: '\$24.99'),
    (name: 'Matte Liquid Lipstick', price: '\$14.50'),
    (name: 'Vitamin C Face Cream', price: '\$19.99'),
    (name: 'Rose Water Toner', price: '\$11.25'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTopBarMain(),
            SizedBox(height: 16.h),
            CommonText(
              "My Favorites",
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: GridView.builder(
                itemCount: _products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return CommonProductCard(
                    imagePath: "assets/jpg/dummy_product.jpg",
                    name: product.name,
                    price: product.price,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
