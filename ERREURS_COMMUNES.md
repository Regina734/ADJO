# ⚠️ Erreurs Courantes et Leurs Solutions

## 1. "Scaffold vide" après Login

### ❌ ERREUR
```dart
// Vieux code
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const Scaffold()), // ❌ Vide!
);
```

### ✅ CORRECT
```dart
// Nouveau code
Navigator.pushNamedAndRemoveUntil(
  context,
  AppRouter.dashboard,
  (route) => false,
);
```

**Explication**: Utilisez `AppRouter.dashboard` qui pointe vers `DashboardScreen()` (avec NavBar), pas un `Scaffold()` vide.

---

## 2. NavBar n'apparaît pas

### ❌ ERREUR
```dart
// HomeScreen sans navbar
Scaffold(
  backgroundColor: Colors.black,
  body: ListView(...),
);
```

### ✅ CORRECT
```dart
// Utilisez DashboardScreen qui inclut navbar
Navigator.pushNamed(context, AppRouter.dashboard);

// Ou pour index spécifique:
Navigator.pushNamed(context, AppRouter.myBox); // → DashboardScreen(initialIndex: 2)
```

**Explication**: `DashboardScreen` ajoute automatiquement la navbar. Les écrans individuels (HomeScreen, etc.) ne l'ont pas.

---

## 3. Onglets ne changent pas

### ❌ ERREUR
```dart
// AppBottomNavBar reçoit mauvais index
AppBottomNavBar(
  currentIndex: 5, // ❌ Doit être 0-3!
  onTap: (index) => print(index),
)
```

### ✅ CORRECT
```dart
// Index valides: 0, 1, 2, 3
AppBottomNavBar(
  currentIndex: 0, // ✅ HomeScreen
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
)
```

**Explication**: Seuls 4 onglets (0-3). `DashboardScreen` gère la validation.

---

## 4. Erreurs de login ne s'affichent pas

### ❌ ERREUR
```dart
// Pas d'exception lancée
if (phone != "0161762591") {
  return false; // ❌ Pas d'erreur visible
}
```

### ✅ CORRECT
```dart
// Lancez une exception
if (!_mockUsers.containsKey(phone)) {
  throw Exception('Invalid phone number');
}

// Dans le widget:
catch (e) {
  setState(() {
    _errorMessage = e.toString().replaceAll('Exception: ', '');
  });
}
```

**Explication**: Les exceptions doivent être lancées et attrapées pour afficher le feedback.

---

## 5. AuthService pas persistant

### ❌ ERREUR
```dart
// Pas de sauvegarde
Future<User> login(String phone, String password) async {
  _currentUser = user; // ❌ Oublié après redémarrage
}
```

### ✅ CORRECT
```dart
// Sauvegardez dans storage
Future<User> login(String phone, String password) async {
  _currentUser = user;
  
  // ✅ Persistez
  await StorageService().saveString('auth_token', 'token_$phone');
  await StorageService().saveString('user_phone', phone);
}
```

**Explication**: Utilisez `StorageService` pour sauvegarder la session entre redémarrages.

---

## 6. FAB menu ne s'affiche pas

### ❌ ERREUR
```dart
// onAddPressed est null
AppBottomNavBar(
  onAddPressed: null, // ❌ Menu ne s'affiche pas
)
```

### ✅ CORRECT
```dart
// Donnez une fonction
AppBottomNavBar(
  onAddPressed: () {
    _showAddMenu(); // ✅ Affiche le menu
  },
)
```

**Explication**: Le callback doit être non-null et effectuer une action.

---

## 7. Navigation circulaire

### ❌ ERREUR
```dart
// Boucle infinie
case AppRouter.dashboard:
  return _buildRoute(HomeScreen()); // ❌ Renvoie HomeScreen au lieu de Dashboard

// Dans HomeScreen:
Navigator.pushNamed(context, AppRouter.myBox); // → HomeScreen → HomeScreen...
```

### ✅ CORRECT
```dart
// Route correcte
case AppRouter.dashboard:
  return _buildRoute(const DashboardScreen()); // ✅ Bon

// Dans HomeScreen (à l'intérieur Dashboard):
// Juste utiliser onTap de la navbar, pas Navigator
```

**Explication**: `DashboardScreen` contient tous les écrans. Ne les navigez pas directement.

---

## 8. Validation de formulaire

### ❌ ERREUR
```dart
// Validation insuffisante
String? _validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter phone';
  }
  return null; // ❌ Permet "123" (trop court)
}
```

### ✅ CORRECT
```dart
String? _validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter phone';
  }
  if (value.length < 7) {
    return 'Please enter a valid phone number'; // ✅ Vérifie longueur
  }
  return null;
}
```

---

## 9. ListeningState sans dispose

### ❌ ERREUR
```dart
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;
  
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(); // ❌ Pas de dispose
  }
}
```

### ✅ CORRECT
```dart
class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;
  
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }
  
  @override
  void dispose() {
    _phoneController.dispose(); // ✅ Nettoie ressources
    super.dispose();
  }
}
```

---

## 10. Dépréciation: AppRouter.navigateTo

### ❌ ERREUR
```dart
// Utilise méthode helper qui peut ne pas exister
AppRouter.navigateTo(context, AppRouter.forgotPassword);
```

### ✅ CORRECT
```dart
// Utilise Navigator directement
Navigator.pushNamed(context, AppRouter.forgotPassword);
```

**Explication**: Les méthodes helper sont optionnelles. Préférez `Navigator.pushNamed()`.

---

## 11. Accès à AuthService sans instance

### ❌ ERREUR
```dart
// Crée nouvelle instance à chaque fois
Future<void> _login() async {
  final user = await AuthService().login(...); // ❌ Nouvelle instance chaque fois
}
```

### ✅ CORRECT
```dart
// Singleton - même instance toujours
class LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService(); // ✅ Créé une fois
  
  Future<void> _login() async {
    final user = await _authService.login(...); // ✅ Utilise même instance
  }
}
```

**Explication**: `AuthService` est un singleton. Utilisez `final _authService = AuthService()`.

---

## 12. Affichage de sensible data

### ❌ ERREUR
```dart
// Ne mettez JAMAIS de vraies données sensibles en test
print('User: ${user.email} | Password: ${password}'); // ❌ Danger!
```

### ✅ CORRECT
```dart
// Utilisez les données mock fournis ou une vraie API
print('Login successful for user: ${user.name}'); // ✅ Safe
```

**Explication**: Les données de test sont en mock data pour la sécurité.

---

## 📋 Checklist Avant de Tester

- [ ] Utilisé `DashboardScreen` pas `HomeScreen`
- [ ] Index de NavBar entre 0-3
- [ ] `AuthService` est singleton
- [ ] Exceptions lancées et attrapées
- [ ] StorageService utilisé pour persistance
- [ ] FAB callback n'est pas null
- [ ] Pas de navigation circulaire
- [ ] Controllers disposés dans State
- [ ] Pas de données sensibles affichées
- [ ] Routes pointent aux bons écrans

---

**Besoin d'aide? Consultez GUIDE_COMPLET.md** 📚
