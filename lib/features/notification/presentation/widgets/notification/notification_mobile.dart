import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';

class NotificationMobile extends StatelessWidget {
  const NotificationMobile({super.key});

  static const _notifications =
      <({String title, String message, String time, IconData icon, bool isUnread})>[
        (
          title: 'Order Shipped',
          message: 'Your order #1234 has been shipped.',
          time: '2h ago',
          icon: AmazingIconBroken.bag2,
          isUnread: true,
        ),
        (
          title: 'Flash Sale!',
          message: 'Get 20% off on all skincare products today.',
          time: '5h ago',
          icon: AmazingIconBroken.discountCircle,
          isUnread: true,
        ),
        (
          title: 'Order Delivered',
          message: 'Your order #1230 was delivered successfully.',
          time: '1d ago',
          icon: AmazingIconBroken.bag2,
          isUnread: false,
        ),
        (
          title: 'New Arrival',
          message: 'Check out our new Vitamin C skincare range.',
          time: '2d ago',
          icon: AmazingIconBroken.gift,
          isUnread: false,
        ),
        (
          title: 'Payment Successful',
          message: 'Your payment of \$79.96 was successful.',
          time: '3d ago',
          icon: AmazingIconBroken.wallet,
          isUnread: false,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      AmazingIconBroken.arrowLeft,
                      size: 18.sp,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                CommonText(
                  "Notifications",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepNavy,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                itemCount: _notifications.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: notification.isUnread
                          ? AppColors.primaryBlue.withValues(alpha: 0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.softBlueGray.withValues(alpha: 0.45),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 44.w,
                          width: 44.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            notification.icon,
                            size: 20.sp,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                notification.title,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepNavy,
                              ),
                              SizedBox(height: 4.h),
                              CommonText(
                                notification.message,
                                fontSize: 12.sp,
                                color: AppColors.deepNavy.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              CommonText(
                                notification.time,
                                fontSize: 11.sp,
                                color: AppColors.deepNavy.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (notification.isUnread)
                          Container(
                            height: 8.w,
                            width: 8.w,
                            margin: EdgeInsets.only(top: 4.h),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
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
