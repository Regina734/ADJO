import 'package:adjo/screens/dashboard/dashboard_screen.dart';
import 'package:adjo/screens/auth/splash_screen.dart';
import 'package:adjo/screens/onboarding/Welcome_screen.dart';
import 'package:adjo/screens/onboarding/feature/feature_configure_box.dart';
import 'package:adjo/screens/onboarding/feature/feature_selection.dart';
import 'package:adjo/screens/my_box/my_box_screen.dart';
import 'package:adjo/screens/my_box/send_funds_screen.dart';
import 'package:adjo/screens/community/create_community_screen.dart';
import 'package:adjo/screens/community/validate_community_screen.dart';
import 'package:adjo/screens/tontine/all_tontine_screen.dart';
import 'package:adjo/screens/tontine/create_tontine_screen.dart';
import 'package:adjo/screens/tontine/choose_members_screen.dart';
import 'package:adjo/screens/tontine/detail_members_screen.dart';
import 'package:adjo/screens/tontine/caution_details_screen.dart';
import 'package:adjo/screens/tontine/deposit_caution_screen.dart';
import 'package:adjo/screens/tontine/success_tontine_screen.dart';
import 'package:adjo/screens/settings/upgrade_premium_modal.dart';
import 'package:adjo/screens/settings/profile_screen.dart';
import 'package:adjo/screens/academy/academy_screen.dart' as academy_screen;
import 'package:adjo/screens/auth/signup_screen.dart';
import 'package:adjo/screens/auth/login_screen.dart';
import 'package:adjo/screens/auth/forgot_password_screen.dart';
import 'package:adjo/screens/auth/verification_screen.dart';
import 'package:adjo/screens/staking_simulation.dart';
import 'package:adjo/screens/daily_quiz_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  // Routes constants
  static const String splash = '/splash';
  static const String welcome = '/';
  static const String language = '/language';
  static const String featureSelection = '/feature-selection';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String myBox = '/my-box';
  static const String configureBox = '/configure-box';
  static const String staking = '/staking';
  static const String stakingSetup = '/staking-setup';
  static const String stakingValidate = '/staking-validate';
  static const String sendFunds = '/send-funds';
  static const String confirmation = '/confirmation';
  static const String transactionSuccess = '/transaction-success';
  static const String allTontines = '/all-tontines';
  static const String myTontine = '/my-tontine';
  static const String createTontine = '/create-tontine';
  static const String chooseMembers = '/choose-members';
  static const String detailMembers = '/detail-members';
  static const String cautionDetails = '/caution-details';
  static const String depositCaution = '/deposit-caution';
  static const String successTontine = '/success-tontine';
  static const String tontineDetails = '/tontine-details';
  static const String upgradePremium = '/upgrade-premium';
  static const String selectCommunity = '/select-community';
  static const String myCommunity = '/my-community';
  static const String createCommunity = '/create-community-new';
  static const String validateCommunity = '/validate-community';
  static const String createCommunityOld = '/create-community';
  static const String editProfile = '/edit-profile';
  static const String academy = '/academy';
  static const String settings = '/settings';
  static const String stakingSimulation = '/staking-simulation';
  static const String dailyQuiz = '/daily-quiz';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // Auth
      case splash:
        return _buildRoute(const SplashScreen());

      // Onboarding
      case welcome:
        return _buildRoute(WelcomeScreen());

      case featureSelection:
        return _buildRoute(FeatureSelectionScreen());

      // Auth
      case signup:
        return _buildRoute(SignupScreen());

      case login:
        return _buildRoute(LoginScreen());

      case forgotPassword:
        return _buildRoute(ForgotPasswordScreen());

      case verification:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          VerificationScreen(phoneNumber: args?['phoneNumber'] ?? ''),
        );

      case resetPassword:
        return _buildRoute(LoginScreen());

      // Dashboard
      case dashboard:
        return _buildRoute(const DashboardScreen());

      // My Box
      case myBox:
        return _buildRoute(const DashboardScreen(initialIndex: 2));

      case configureBox:
        return _buildRoute(const ConfigureBoxScreen());

      case staking:
        return _buildRoute(const MyBoxScreen());

      case sendFunds:
        return _buildRoute(const SendFundsScreen());

      case transactionSuccess:
        return _buildRoute(const MyBoxScreen());

      // Tontine
      case myTontine:
        return _buildRoute(const DashboardScreen(initialIndex: 3));

      case allTontines:
        return _buildRoute(const AllTontineScreen());

      case createTontine:
        return _buildRoute(const CreateTontineScreen());

      case chooseMembers:
        return _buildRoute(const ChooseMembersScreen());

      case detailMembers:
        return _buildRoute(const DetailMembersScreen());

      case cautionDetails:
        return _buildRoute(const CautionDetailsScreen());

      case depositCaution:
        return _buildRoute(const DepositCautionScreen());

      case successTontine:
        return _buildRoute(const SuccessTontineScreen());

      case tontineDetails:
        return _buildRoute(const MyTontineScreen());

      // Community
      case myCommunity:
        return _buildRoute(const DashboardScreen(initialIndex: 1));

      case createCommunity:
      case createCommunityOld:
        return _buildRoute(const CreateCommunityScreen());

      case validateCommunity:
        return _buildRoute(const ValidateCommunityScreen());

      // Academy
      case academy:
        return _buildRoute(academy_screen.AcademyScreen());

      // Settings
      case settings:
        return _buildRoute(const DashboardScreen(initialIndex: 4));

      case upgradePremium:
        return _buildRoute(const UpgradePremiumModal());

      case editProfile:
        return _buildRoute(const EditProfileScreen());

      case stakingSimulation:
        return _buildRoute(const StakingSimulationScreen());

      case dailyQuiz:
        return _buildRoute(const DailyQuizScreen());

      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('Page not found: ${routeSettings.name}')),
          ),
        );
    }
  }

  static MaterialPageRoute _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }

  // Navigation helpers
  static void navigateTo(
    BuildContext context,
    String route, {
    Object? arguments,
  }) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static void navigateAndReplace(
    BuildContext context,
    String route, {
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  }

  static void navigateAndClearStack(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
