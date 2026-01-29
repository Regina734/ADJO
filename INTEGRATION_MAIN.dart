/// Exemple d'intégration AuthService dans main.dart
/// 
/// Pour utiliser l'authentification réelle, ajoutez ceci à main():
/// 
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await StorageService().init();
///   
///   // ✨ NOUVEAU: Vérifier et restaurer session existante
///   final authService = AuthService();
///   final hasSession = await authService.isAuthenticated();
///   
///   // ✨ NOUVEAU: Afficher les comptes de test en développement
///   if (kDebugMode) {
///     TestConfig.printTestInfo();
///   }
///
///   SystemChrome.setPreferredOrientations([
///     DeviceOrientation.portraitUp,
///   ]);
///
///   runApp(const MyApp(hasSession: hasSession));
/// }
///
/// class MyApp extends StatelessWidget {
///   final bool hasSession;
///   
///   const MyApp({
///     super.key,
///     this.hasSession = false,
///   });
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       debugShowCheckedModeBanner: false,
///       theme: AppTheme.darkTheme,
///       // ✨ NOUVEAU: Routage intelligent basé sur session
///       initialRoute: hasSession ? AppRouter.dashboard : AppRouter.welcome,
///       onGenerateRoute: AppRouter.generateRoute,
///     );
///   }
/// }
/// ```
///
/// Imports à ajouter:
/// ```dart
/// import 'package:adjo/services/auth_service.dart';
/// import 'package:adjo/config/test_config.dart';
/// import 'package:flutter/foundation.dart';
/// ```

// Ce fichier est juste une documentation, pas du code à exécuter
