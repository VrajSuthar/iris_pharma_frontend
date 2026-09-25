import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Row of dots showing the active page of a PageView.
class DotPageIndicator extends StatelessWidget {
  const DotPageIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
    this.color = Colors.white,
    this.inactiveColor = Colors.white38,
    this.dotSize = 8,
    this.activeDotWidth = 20,
    this.spacing = 6,
  });

  final int count;
  final int activeIndex;
  final Color color;
  final Color inactiveColor;
  final double dotSize;
  final double activeDotWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: spacing.w / 2),
          width: (isActive ? activeDotWidth : dotSize).w,
          height: dotSize.h,
          decoration: BoxDecoration(
            color: isActive ? color : inactiveColor,
            borderRadius: BorderRadius.circular(dotSize.h / 2),
          ),
        );
      }),
    );
  }
}
