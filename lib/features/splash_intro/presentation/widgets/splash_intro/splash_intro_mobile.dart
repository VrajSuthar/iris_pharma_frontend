import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/common_text.dart';
import '../../../../../core/widgets/dot_page_indicator.dart';

/// Pure UI for the splash intro carousel. Holds no state of its own —
/// [page] and [controller] come from the provider via the screen.
class SplashIntroMobile extends StatelessWidget {
  const SplashIntroMobile({
    super.key,
    required this.images,
    required this.controller,
    required this.page,
    required this.onPageChanged,
    required this.onGetStarted,
  });

  final List<String> images;
  final PageController controller;
  final int page;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          pageSnapping: false,
          physics: const ClampingScrollPhysics(),
          itemCount: images.length,
          onPageChanged: onPageChanged,
          itemBuilder: (context, index) => SizedBox.expand(
            child: Image.asset(images[index], fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.35, 0.65, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DotPageIndicator(count: images.length, activeIndex: page),
                  SizedBox(height: 16.h),
                  CommonText(
                        "Glow Starts With Healthy Skin",
                        style: GoogleFonts.specialElite(),
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )
                      .animate()
                      .fadeIn(
                        delay: 300.ms,
                        duration: 700.ms,
                        curve: Curves.easeOut,
                      )
                      .slideY(
                        begin: 0.4,
                        end: 0,
                        delay: 300.ms,
                        duration: 700.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .scale(
                        begin: const Offset(0.85, 0.85),
                        end: const Offset(1, 1),
                        delay: 300.ms,
                        duration: 700.ms,
                        curve: Curves.easeOutBack,
                      )
                      .shimmer(
                        delay: 900.ms,
                        duration: 1200.ms,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),

                  const CommonText(
                        "Discover premium skincare products designed to nourish, hydrate, and reveal your natural glow.",
                        fontSize: 16,
                        color: Colors.white,
                      )
                      .animate()
                      .fadeIn(
                        delay: 700.ms,
                        duration: 700.ms,
                        curve: Curves.easeOut,
                      )
                      .blur(
                        begin: const Offset(4, 4),
                        end: const Offset(0, 0),
                        delay: 700.ms,
                        duration: 700.ms,
                      )
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 700.ms,
                        duration: 700.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .then()
                      .shimmer(
                        delay: 300.ms,
                        duration: 1200.ms,
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child:
                        GestureDetector(
                              onTap: onGetStarted,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CommonText(
                                      "Get Started",
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                    SizedBox(width: 8.w),
                                    const Icon(
                                      AmazingIconBroken.arrowRight,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(
                              delay: 1100.ms,
                              duration: 600.ms,
                              curve: Curves.easeOut,
                            )
                            .slideY(
                              begin: 0.5,
                              end: 0,
                              delay: 1100.ms,
                              duration: 600.ms,
                              curve: Curves.easeOutBack,
                            )
                            .scale(
                              begin: const Offset(0.85, 0.85),
                              end: const Offset(1, 1),
                              delay: 1100.ms,
                              duration: 600.ms,
                              curve: Curves.easeOutBack,
                            )
                            .then()
                            .shimmer(
                              duration: 1800.ms,
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
