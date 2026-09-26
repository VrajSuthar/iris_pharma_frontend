import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/route_paths.dart';
import '../../app/theme/app_colors.dart';
import 'common_text.dart';

class CommonTopBarMain extends StatelessWidget {
  const CommonTopBarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile image
        Container(
          height: 56.h,
          width: 56.w,
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryBlue,
                AppColors.primaryBlue.withValues(alpha: 0.4),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: Image.asset("assets/jpg/dumm1.jpg", fit: BoxFit.cover),
          ),
        ),

        SizedBox(width: 14.w),

        // Greeting
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                "Welcome back,",
                fontSize: 13.sp,
                color: AppColors.deepNavy.withValues(alpha: 0.55),
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 2.h),
              CommonText(
                "Vraj Suthar",
                fontSize: 18.sp,
                color: AppColors.deepNavy,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),

        SizedBox(width: 8.w),

        // Notification
        GestureDetector(
          onTap: () => context.push(RoutePaths.notifications),
          child: Icon(AmazingIconBroken.notification, size: 32.sp),
        ),
      ],
    );
  }
}
