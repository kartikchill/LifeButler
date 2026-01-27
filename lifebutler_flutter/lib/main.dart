import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'app.dart';
import 'services/notification_service.dart';
import 'services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService().init();
  await NotificationService().init();
  await AndroidAlarmManager.initialize();
  runApp(const LifeButlerApp());
}
