# 🎯 Checklist - Priorités Restantes

## ✅ CRITIQUE (COMPLÉTÉES)

- [x] StorageService - Ajouter getString/setString
- [x] Assets - Ajouter images (blockchain.svg, smart-contracts.svg, security.svg)
- [x] BottomNavBar - Corriger indices (0→2, 1→1, 2→3, 3→4)
- [x] Navigation - Intégrer SplashScreen pour auth check
- [x] Compilation - Résoudre erreurs (168→154 issues)

---

## ⚠️ IMPORTANT (À FAIRE MAINTENANT)

### 1. 🔐 Auth Persistence - Validation
- [ ] Tester: Login → Fermer app → Redémarrer → Doit être au Dashboard
- [ ] Tester: Logout → Fermer app → Redémarrer → Doit être à Welcome/Login
- [ ] Vérifier que tokens sont bien sauvegardés en SharedPreferences

**Fichiers impliqués:**
- `lib/services/auth_service.dart` - isAuthenticated()
- `lib/services/storage_service.dart` - getString/setString
- `lib/screens/auth/splash_screen.dart` - Check au démarrage

### 2. 🏠 Home Screen - Cards UI
- [ ] Créer cartes attrayantes pour les sections principales
- [ ] Afficher:
  - Balance/Stats utilisateur
  - Tontines actives
  - Communities
  - Récompenses
- [ ] Style cohérent avec design (doré #FDB834, sombre #1A1A1A)

**Fichier:** `lib/screens/dashboard/home_screen.dart`

### 3. 🔧 Services Implementation
- [ ] Créer CommunityService (actuellement manquant)
  - getAll()
  - create()
  - join()
  - getMembers()
- [ ] Améliorer TontineService avec logique réelle
- [ ] Améliorer MyBoxService (transactions, balance)

**Fichiers:** `lib/services/community_service.dart`, `lib/services/tontine_service.dart`

### 4. 📊 Quiz Integration
- [ ] Connecter DailyQuizScreen au MainScreen
- [ ] Intégrer points de quiz à la balance utilisateur
- [ ] Afficher streak de quiz sur HomeScreen

**Fichiers:** `lib/screens/daily_quiz_screen.dart`, `lib/models/user.dart`

---

## 🎁 NICE TO HAVE (Si temps disponible)

### 1. ✨ Animations
- [ ] Page transitions (fade, slide)
- [ ] FAB button animation
- [ ] NavBar item transitions
- [ ] Card loading shimmer

**Package:** Utiliser `flutter_animate` ou animations native

### 2. 🔗 Blockchain Staking
- [ ] Intégrer API Stellar réelle
- [ ] Créer StakingService
- [ ] Valider transactions blockchain
- [ ] Afficher status de staking

**Fichiers:** `lib/services/blockchain_service.dart`, `lib/screens/staking_simulation.dart`

### 3. 📱 Polish & UX
- [ ] Ajouter haptic feedback (vibrations)
- [ ] Optimiser performance
- [ ] Ajouter erreur boundaries
- [ ] Meilleure gestion état (Provider/Riverpod au lieu de StatefulWidget)

---

## 🐛 Bugs Connus & À Vérifier

| Bug | Priorité | Status |
|-----|----------|--------|
| FAB menu options ne naviguent pas | HIGH | À vérifier |
| HomeScreen pas encore implémentée | HIGH | À faire |
| CommunityService manquante | HIGH | À créer |
| Images encore en SVG (pas JPEG) | MEDIUM | À remplacer |
| Erreurs withOpacity deprecated | LOW | À fixer (cosmétique) |

---

## 📋 Testing Checklist

### Navigation Flow
- [ ] App démarre → SplashScreen visible
- [ ] Pas connecté → WelcomeScreen après splash
- [ ] Connecté → Dashboard directement après splash
- [ ] LoginScreen → 3 comptes de test fonctionnent
- [ ] Tapper sur onglets → change d'écran correctement
- [ ] FAB menu s'ouvre → 3 options visibles
- [ ] Logout → retour à LoginScreen

### UI/UX Checks
- [ ] Colors corrects (doré #FDB834, sombre #1A1A1A)
- [ ] NavBar visible et réactif
- [ ] FAB button visible au centre
- [ ] Pas de lag ou freeze
- [ ] Clavier s'ouvre/ferme correctement

### Data Persistence
- [ ] Login → tokens sauvegardés
- [ ] Redémarrage app → session restaurée
- [ ] Logout → tokens supprimés
- [ ] App crash → session récupérée

---

## 📝 Notes Développement

**Patterns utilisés:**
- Singleton pour AuthService & StorageService
- StatefulWidget pour DashboardScreen
- MockData pour simulations

**À considérer pour refactor future:**
- Provider package pour state management
- GetX pour routing plus simple
- Riverpod pour reactive programming

**Dependances à ajouter bientôt:**
- `flutter_animate` pour animations
- `vibration` pour haptic feedback
- Stellar SDK pour blockchain réel

---

## 🔄 Cycle de Développement

```
Cycle 1 (EN COURS):
├─ CRITIQUE: Corrections stockage/nav ✅
└─ Objectif: App compiles sans erreurs ✅

Cycle 2 (COMMENCER):
├─ IMPORTANT: Auth + HomeScreen + Services
└─ Objectif: App fonctionnelle avec data réelle

Cycle 3:
├─ NICE TO HAVE: Animations + Blockchain
└─ Objectif: App polish et prête production
```

---

## 👤 Comptes Test - Rappel

```
Téléphone: 0161762591  | MDP: Karim&1234    | Nom: Karim Diallo
Téléphone: 0165432109  | MDP: Test&1234     | Nom: Test User  
Téléphone: 0123456789  | MDP: Demo&1234     | Nom: Demo Account
```

💡 Tip: LoginScreen a un bouton "?" qui auto-remplit avec tous les comptes

---

## 📞 Questions Récurrentes

**Q: Pourquoi SplashScreen?**
A: Pour vérifier l'authentification sans afficher Welcome/Login si connecté

**Q: Pourquoi certaines images encore SVG?**
A: Placeholders temporaires - remplacer par vrais JPG/PNG avant production

**Q: Pourquoi StorageService sync pour getter?**
A: SharedPreferences getter est sync, setter est async

**Q: Comment tester la persistance?**
A: Login → Fermer complètement l'app → Redémarrer → Doit être au Dashboard

