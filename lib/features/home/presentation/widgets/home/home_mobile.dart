import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../../core/widgets/common_product_card.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../../core/widgets/common_text_form_field.dart';
import '../../../../../core/widgets/common_top_bar_main.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  static const _categories = <({String label, IconData icon})>[
    (label: 'Skincare', icon: AmazingIconBroken.drop),
    (label: 'Makeup', icon: AmazingIconBroken.brush),
    (label: 'Haircare', icon: AmazingIconBroken.scissor),
    (label: 'Bath & Body', icon: AmazingIconBroken.heartCircle),
    (label: 'Fragrance', icon: AmazingIconBroken.gift),
    (label: 'Wellness', icon: AmazingIconBroken.heart),
    (label: 'Tools', icon: AmazingIconBroken.brush2),
    (label: 'Best Sellers', icon: AmazingIconBroken.star),
  ];

  static const _products = <({String name, String price})>[
    (name: 'Hydrating Facial Serum', price: '\$24.99'),
    (name: 'Matte Liquid Lipstick', price: '\$14.50'),
    (name: 'Vitamin C Face Cream', price: '\$19.99'),
    (name: 'Rose Water Toner', price: '\$11.25'),
    (name: 'Argan Hair Oil', price: '\$16.99'),
    (name: 'Charcoal Face Mask', price: '\$13.75'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTopBarMain(),
              SizedBox(height: 16.h),
              CommonTextFormField(
                prefixIcon: Icon(AmazingIconBroken.searchNormal1),
                hintText: "Search...",
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 0.25.sh,
                width: 1.sw,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16.r),
                      child: Image.asset(
                        "assets/jpg/offer_dummy.jpg",
                        fit: BoxFit.cover,
                        height: 0.25.sh,
                        width: 1.sw,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: CommonText(
                          "Shop now",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CommonText("Category", fontSize: 24, fontWeight: FontWeight.w700),
              SizedBox(height: 12.h),
              SizedBox(
                height: 88.h,
                width: 1.sw,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Column(
                        children: [
                          Container(
                            height: 56.w,
                            width: 56.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withValues(
                                alpha: 0.08,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              category.icon,
                              color: AppColors.primaryBlue,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CommonText(
                            category.label,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.deepNavy,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              CommonText(
                "Popular Products",
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 12.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
            ],
          ),
        ),
      ),
    );
  }
}
