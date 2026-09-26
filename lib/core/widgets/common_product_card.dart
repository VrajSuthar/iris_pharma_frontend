import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';
import 'common_text.dart';

/// App-wide product card. Shows an image with a favorite button, name, and
/// price.
class CommonProductCard extends StatelessWidget {
  const CommonProductCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    this.onTap,
    this.onFavoriteTap,
  });

  final String imagePath;
  final String name;
  final String price;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: AppColors.softBlueGray.withValues(alpha: 0.45),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 0.22.sh,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16.r),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Icon(
                      AmazingIconBroken.heart,
                      size: 28.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(name, fontWeight: FontWeight.w600),
                  SizedBox(height: 4),
                  CommonText(price, fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
