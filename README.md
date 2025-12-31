# Adjó - Application de Tontine Décentralisée

[![Flutter](https://img.shields.io/badge/Flutter-3.16+-blue.svg)](https://flutter.dev/)
[![Rust](https://img.shields.io/badge/Rust-1.75+-orange.svg)](https://www.rust-lang.org/)
[![Stellar](https://img.shields.io/badge/Stellar-Blockchain-purple.svg)](https://www.stellar.org/)

Application mobile de tontine décentralisée combinant les pratiques traditionnelles africaines avec la technologie blockchain Stellar.

##  Vision

Digitaliser la tontine traditionnelle de manière sécurisée et transparente, tout en initiant les utilisateurs à la blockchain de façon progressive et pédagogique.

##  Structure du projet
```
ADJO/
├── frontend/        # 📱 Application mobile Flutter (iOS & Android)
├── backend/         # ⚙️ API REST en Rust
├── blockchain/      # ⛓️ Smart contracts Stellar
├── docs/            # 📚 Documentation du projet
└── scripts/         # 🔧 Scripts utilitaires
```

##  Démarrage rapide

### Frontend (Flutter)
```bash
cd frontend
flutter pub get
flutter run
```

### Backend (Rust) - En développement
```bash
cd backend
cargo build
cargo run
```

### Blockchain (Stellar) - En développement
```bash
cd blockchain
npm install
npm start
```

##  Fonctionnalités

### Module My Box (Épargne individuelle)
- Création d'une box personnelle
- Dépôt et suivi des contributions
- Historique des transactions
- Visualisation des gains

### Module My Community (Gestion communautaire)
- Création ou adhésion à une communauté
- Gestion des membres
- Règles de fonctionnement du groupe
- Notifications et rappels

### Module My Tontine (Gestion des tontines)
- Création de tontines (classiques ou décentralisées)
- Attribution automatique des tours
- Smart contracts pour automatiser les règles
- Suivi transparent des contributions

### Module d'apprentissage
- FAQ interactive
- Mode démo sans engagement financier
- Parcours guidé d'initiation à la blockchain

##  Langues supportées

- 🇫🇷 Français
- 🇬🇧 English
- 🇧🇯 Fon

##  Documentation

- [📋 Cahier des charges](docs/cahier-de-charges.md)
- [📱 Frontend README](frontend/README.md)
- [⚙️ Backend README](backend/README.md)
- [⛓️ Blockchain README](blockchain/README.md)

##  Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m ' feat: Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

##  Workflow Git
```
main (production)
  └── develop (développement)
      ├── feature/my-box
      ├── feature/my-community
      └── feature/blockchain-integration
```

##  Modèle économique

### Offre gratuite
- Accès à une seule tontine
- Fonctionnalités de base
- Publicités responsables

### Offre premium (abonnement)
- Accès illimité aux tontines
- Sans publicités
- Outils avancés de suivi

##  Stack technique

- **Frontend**: Flutter 3.16+
- **Backend**: Rust avec Actix-web
- **Blockchain**: Stellar (Soroban)
- **Base de données**: PostgreSQL

##  Équipe

- **Lead Developer**: Regina
- **Repository**: [github.com/Regina734/ADJO](https://github.com/Regina734/ADJO)

## 📄 Licence

MIT License

## 🔗 Liens utiles

- [Documentation Flutter](https://flutter.dev/docs)
- [Rust Book](https://doc.rust-lang.org/book/)
- [Stellar Developers](https://developers.stellar.org/)

---

Made with ❤️ for African communities


