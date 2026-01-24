// ============================================
// 4. /lib/services/storage_service.dart
// ============================================
// Pour sauvegarder les préférences (langue, etc.)

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Langue
  Future<void> setLanguage(String language) async {
    await _prefs?.setString('language', language);
  }

  String getLanguage() {
    return _prefs?.getString('language') ?? 'fr';
  }

  // Première ouverture
  Future<void> setFirstTime(bool value) async {
    await _prefs?.setBool('first_time', value);
  }

  bool isFirstTime() {
    return _prefs?.getBool('first_time') ?? true;
  }

  // Feature sélectionnée (pour freemium)
  Future<void> setSelectedFeature(String feature) async {
    await _prefs?.setString('selected_feature', feature);
  }

  String? getSelectedFeature() {
    return _prefs?.getString('selected_feature');
  }
}
