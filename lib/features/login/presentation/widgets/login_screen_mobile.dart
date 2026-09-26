import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/common_text_form_field.dart';

class LoginScreenMobile extends HookWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonText(
              'Welcome Back',
              fontSize: 28,
              style: GoogleFonts.specialElite(),
              fontWeight: FontWeight.w700,
            ),
            const CommonText(
              'Your beauty essentials are waiting. Log in to continue shopping.',
              fontSize: 14,
            ),
            const SizedBox(height: 32),
            CommonText("Phone", fontSize: 16),
            SizedBox(height: 8),
            CommonTextFormField(
              controller: phoneController,
              hintText: 'Phone number',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(AmazingIconBroken.call),
            ),
            const SizedBox(height: 16),
            CommonText("Password", fontSize: 16),
            SizedBox(height: 8),
            CommonTextFormField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: obscurePassword.value,
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(AmazingIconBroken.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword.value
                      ? AmazingIconBroken.eye
                      : AmazingIconBroken.eyeSlash,
                ),
                onPressed: () => obscurePassword.value = !obscurePassword.value,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: CommonText("Forgot password ?", fontSize: 16),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.go(RoutePaths.main),
              child: Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(64.r),
                ),
                child: Center(
                  child: CommonText(
                    "Log in",
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
