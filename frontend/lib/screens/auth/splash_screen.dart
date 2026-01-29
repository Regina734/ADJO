import 'package:adjo/app_router.dart';
import 'package:adjo/services/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Add a small delay for better UX
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user is already authenticated
    final isAuthenticated = await _authService.isAuthenticated();

    if (mounted) {
      if (isAuthenticated) {
        // Navigate to dashboard if user is logged in
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRouter.dashboard, (route) => false);
      } else {
        // Navigate to welcome screen if user is not logged in
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRouter.welcome, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or branding
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFDB834).withOpacity(0.2),
              ),
              child: const Icon(
                Icons.savings,
                size: 60,
                color: Color(0xFFFDB834),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ADJO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tontine & Community',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 48),
            // Loading indicator
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDB834)),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
