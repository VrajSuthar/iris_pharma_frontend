import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/widgets/common_text.dart';

class LoginScreenMobile extends HookWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CommonText(
              'Welcome Back',
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 8),
            const CommonText('Login to continue', fontSize: 14),
            const SizedBox(height: 32),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: 'Phone number'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: obscurePassword.value,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      obscurePassword.value = !obscurePassword.value,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.push(RoutePaths.forgotPassword),
                child: const CommonText('Forgot password?', fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go(RoutePaths.home),
                child: const CommonText(
                  'Login',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
