import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../../../core/widgets/common_top_bar_main.dart';

class CartMobile extends StatelessWidget {
  const CartMobile({super.key});

  static const _items = <({String name, String price, int quantity})>[
    (name: 'Hydrating Facial Serum', price: '\$24.99', quantity: 1),
    (name: 'Matte Liquid Lipstick', price: '\$14.50', quantity: 2),
    (name: 'Vitamin C Face Cream', price: '\$19.99', quantity: 1),
  ];

  static const _subtotal = '\$74.97';
  static const _delivery = '\$4.99';
  static const _total = '\$79.96';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonTopBarMain(),
            SizedBox(height: 16.h),
            CommonText(
              "My Cart",
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.softBlueGray.withValues(alpha: 0.45),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            "assets/jpg/dummy_product.jpg",
                            height: 64.w,
                            width: 64.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                item.name,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepNavy,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6.h),
                              CommonText(
                                item.price,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryBlue,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              AmazingIconBroken.trash,
                              size: 18.sp,
                              color: AppColors.deepNavy.withValues(alpha: 0.4),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withValues(
                                  alpha: 0.08,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    AmazingIconBroken.minus,
                                    size: 14.sp,
                                    color: AppColors.primaryBlue,
                                  ),
                                  SizedBox(width: 10.w),
                                  CommonText(
                                    '${item.quantity}',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepNavy,
                                  ),
                                  SizedBox(width: 10.w),
                                  Icon(
                                    AmazingIconBroken.add,
                                    size: 14.sp,
                                    color: AppColors.primaryBlue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.softBlueGray.withValues(alpha: 0.45),
                ),
              ),
              child: Column(
                children: [
                  _SummaryRow(label: 'Subtotal', value: _subtotal),
                  SizedBox(height: 8.h),
                  _SummaryRow(label: 'Delivery', value: _delivery),
                  SizedBox(height: 8.h),
                  Divider(color: AppColors.softBlueGray.withValues(alpha: 0.6)),
                  SizedBox(height: 8.h),
                  _SummaryRow(label: 'Total', value: _total, isTotal: true),
                  SizedBox(height: 16.h),
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(64.r),
                    ),
                    child: Center(
                      child: CommonText(
                        "Checkout",
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          label,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          color: isTotal
              ? AppColors.deepNavy
              : AppColors.deepNavy.withValues(alpha: 0.6),
        ),
        CommonText(
          value,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: FontWeight.w700,
          color: isTotal ? AppColors.primaryBlue : AppColors.deepNavy,
        ),
      ],
    );
  }
}
