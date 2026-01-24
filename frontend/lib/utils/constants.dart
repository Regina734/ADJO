import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFD4A574);
  static const secondary = Color(0xFFC49563);
  static const background = Colors.black;
  static const surface = Color(0xFF1A1A1A);
  static const cardDark = Color(0xFF2A2A2A);

  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFA726);
  static const error = Color(0xFFEF5350);

  static const textPrimary = Colors.white;
  static const textSecondary = Colors.grey;
}

class AppText {
  static const appName = 'Adjô';
  static const tagline = 'Unleash your financial potential';
  static const slogan = 'Adjô, Where Your Money Creates Your Freedom';
}

class AppRoutes {
  static const welcome = '/';
  static const language = '/language';
  static const signup = '/signup';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const verification = '/verification';
  static const resetPassword = '/reset-password';
  static const featureSelection = '/feature-selection';
  static const dashboard = '/dashboard';
  static const myBox = '/my-box';
  static const allTontines = '/all-tontines';
  static const createTontine = '/create-tontine';
  static const community = '/community';
  static const academy = '/academy';
  static const settings = '/settings';
}

class AppConstants {
  // App info
  static const String appName = 'Adjó';
  static const String appTagline = 'Unleash your financial potential';
  static const String appVersion = '1.0.0';

  // Currency
  static const String currencyXOF = 'XOF';
  static const String currencyXLM = 'XLM';
  static const double xofToXlmRate = 590.0; // 1 XLM ≈ 590 XOF

  // Subscription types
  static const String subscriptionFree = 'FREE';
  static const String subscriptionPremium = 'PREMIUM';
  static const String subscriptionPro = 'PRO';

  // Subscription prices (monthly)
  static const double premiumPrice = 5.0; // EUR
  static const double proPrice = 20.0; // EUR

  // Blockchain
  static const String blockchainNetwork = 'Stellar';
  static const String stellarTestnet = 'https://horizon-testnet.stellar.org';
  static const String stellarMainnet = 'https://horizon.stellar.org';

  // API (pour plus tard)
  static const String apiBaseUrl = 'https://api.adjo.com/v1';

  // Regex patterns
  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
  static final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$');

  // Limits
  static const int maxTontinesFree = 1;
  static const int maxTontinesPremium = 5;
  static const int maxTontinesPro = 999;

  static const int minStakingAmount = 500; // XOF
  static const int maxStakingAmount = 10000000; // XOF

  // Staking durations (months)
  static const List<int> stakingDurations = [3, 6, 12];

  // Languages
  static const List<Map<String, String>> languages = [
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
    {'code': 'fon', 'name': 'Fon', 'flag': '🇧🇯'},
  ];
}

// Helpers
class CurrencyHelper {
  static String formatXOF(double amount) {
    return '${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} XOF';
  }

  static String formatXLM(double amount) {
    return '${amount.toStringAsFixed(2)} XLM';
  }

  static double xofToXlm(double xof) {
    return xof / AppConstants.xofToXlmRate;
  }

  static double xlmToXof(double xlm) {
    return xlm * AppConstants.xofToXlmRate;
  }
}
