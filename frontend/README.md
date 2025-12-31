#  Adjó Frontend - Flutter App

Application mobile cross-platform pour Adjo.

##  Installation
```bash
flutter pub get
flutter run
```

##  Architecture
```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── utils/
│   └── config/
├── features/
│   ├── auth/
│   │   ├── presentation/
│   │   ├── domain/
│   │   └── data/
│   ├── home/
│   ├── my_box/
│   ├── my_community/
│   └── my_tontine/
└── shared/
    └── widgets/
```

##  Stack technique

- **Framework**: Flutter 3.16+
- **State Management**: Provider / Riverpod
- **Routing**: Go Router
- **HTTP**: Dio
- **Storage**: Hive
- **i18n**: flutter_i18n

##  Plateformes supportées

-  Android
-  iOS
-  Web (en développement)

##  Tests
```bash
flutter test
flutter test --coverage
```

##  Build

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

##  Traductions

Les fichiers de traduction sont dans `assets/translations/`:
- `fr.json` - Français
- `en.json` - English
- `fon.json` - Fon

##  Conventions

- Utiliser `const` partout où possible
- Fichiers en snake_case
- Classes en PascalCase
- Variables en camelCase