import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _keyHasSeenOnboarding = 'hasSeenOnboarding';
  static const String _keyNotificationPermissionAsked = 'notificationPermissionAsked';

  bool get hasSeenOnboarding => _prefs.getBool(_keyHasSeenOnboarding) ?? false;

  Future<void> setHasSeenOnboarding(bool value) async {
    await _prefs.setBool(_keyHasSeenOnboarding, value);
  }

  bool get notificationPermissionAsked => _prefs.getBool(_keyNotificationPermissionAsked) ?? false;

  Future<void> setNotificationPermissionAsked(bool value) async {
    await _prefs.setBool(_keyNotificationPermissionAsked, value);
  }
}
