import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_paths.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../core/widgets/common_text.dart';
import '../../../providers/settings_provider.dart';

class ProfileMobile extends ConsumerWidget {
  const ProfileMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final notifier = ref.read(settingsControllerProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            CommonText("Settings", fontSize: 24, fontWeight: FontWeight.w700),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.softBlueGray.withValues(alpha: 0.45),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 56.w,
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
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28.r),
                      child: Image.asset(
                        "assets/jpg/dumm1.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          "Vraj Suthar",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepNavy,
                        ),
                        SizedBox(height: 2.h),
                        CommonText(
                          "vraj@irispharma.com",
                          fontSize: 12.sp,
                          color: AppColors.deepNavy.withValues(alpha: 0.55),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    AmazingIconBroken.arrowRight,
                    size: 18.sp,
                    color: AppColors.deepNavy.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _sectionLabel('Account'),
            SizedBox(height: 8.h),
            _sectionCard([
              _SettingsTile(
                icon: AmazingIconBroken.profileCircle,
                label: 'Account',
                onTap: () {},
              ),
              _divider(),
              _SettingsTile(
                icon: AmazingIconBroken.wallet,
                label: 'Payment Methods',
                onTap: () {},
              ),
            ]),
            SizedBox(height: 20.h),
            _sectionLabel('Preferences'),
            SizedBox(height: 8.h),
            _sectionCard([
              _SettingsTile(
                icon: AmazingIconBroken.moon,
                label: 'Dark Mode',
                trailing: Switch.adaptive(
                  value: settings.darkMode,
                  activeThumbColor: AppColors.primaryBlue,
                  onChanged: (_) => notifier.toggleDarkMode(),
                ),
              ),
            ]),
            SizedBox(height: 20.h),
            _sectionLabel('Support'),
            SizedBox(height: 8.h),
            _sectionCard([
              _SettingsTile(
                icon: AmazingIconBroken.shield,
                label: 'Privacy & Security',
                onTap: () {},
              ),
              _divider(),
              _SettingsTile(
                icon: AmazingIconBroken.infoCircle,
                label: 'Help & Support',
                onTap: () {},
              ),
            ]),
            SizedBox(height: 20.h),
            _sectionCard([
              _SettingsTile(
                icon: AmazingIconBroken.logout,
                label: 'Logout',
                labelColor: Colors.redAccent,
                iconColor: Colors.redAccent,
                onTap: () => context.go(RoutePaths.login),
              ),
            ]),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return CommonText(
      label,
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.deepNavy.withValues(alpha: 0.5),
    );
  }

  Widget _sectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.softBlueGray.withValues(alpha: 0.45),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      color: AppColors.softBlueGray.withValues(alpha: 0.4),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
    this.labelColor,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? labelColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: iconColor ?? AppColors.primaryBlue),
            SizedBox(width: 14.w),
            Expanded(
              child: CommonText(
                label,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: labelColor ?? AppColors.deepNavy,
              ),
            ),
            trailing ??
                Icon(
                  AmazingIconBroken.arrowRight,
                  size: 16.sp,
                  color: AppColors.deepNavy.withValues(alpha: 0.35),
                ),
          ],
        ),
      ),
    );
  }
}
