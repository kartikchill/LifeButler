import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class ApiService {
  // TODO: Set this to false if you go back to using the Android Emulator
  static const bool isPhysicalDevice = false;

  static final Client client = _createClient();

  static Client _createClient() {
    // Android emulator needs 10.0.2.2 to access host localhost
    // Real Android device needs the LAN IP of the laptop (check ipconfig)
    // flutter run -d chrome uses localhost naturally
    
    String ip;
    if (kIsWeb) {
      ip = 'localhost';
    } else if (Platform.isAndroid) {
      ip = isPhysicalDevice ? '192.168.29.101' : '10.0.2.2';
    } else {
      ip = 'localhost';
    }

    final port = 8080;
    
    // Using flutterConnectivityMonitor handles network state changes
    return Client(
      'http://$ip:$port/',
    )..connectivityMonitor = FlutterConnectivityMonitor();
  }

  static const int demoUserId = 1;

  static Future<List<Goal>> getGoals() {
    return client.goal.getGoals(demoUserId);
  }

  static Future<Goal> createGoal(String title, {
    int targetCount = 1, 
    String periodType = 'month',
    String? consistencyStyle,
    DateTime? anchorTime,
    int? priority,
    String? affirmation,
  }) {
    return client.goal.createGoal(
      userId: demoUserId,
      title: title,
      targetCount: targetCount,
      periodType: periodType,
      consistencyStyle: consistencyStyle,
      anchorTime: anchorTime,
      priority: priority,
      affirmation: affirmation,
    );
    // Note: ensure generated GoalEndpoint client accepts priority.
    // If not, reload window might be needed, but usually works if generated.
  }

  static Future<Goal> completeSession(int goalId) {
    return client.goal.completeGoalSession(goalId);
  }


  static Future<bool> updateGoal(Goal goal) {
    return client.goal.updateGoal(goal);
  }

  static Future<Goal> restartGoal(int goalId) {
    return client.goal.restartGoal(goalId);
  }

  // --- REFLECTIONS (Mocked until Backend Endpoint is fixed) ---
  
  static Future<void> addReflection(Reflection reflection) async {
    // Mimic network delay
    await Future.delayed(const Duration(milliseconds: 500));
    debugPrint('MOCK: Saving reflection: ${reflection.content}');
    // In real implementation: return client.reflection.addReflection(reflection);
  }
  
  static Future<List<Reflection>> getReflectionsForGoal(int goalId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return []; // Return empty for now
  }
  
  static Future<List<Reflection>> getWeeklyReflections() async {
     await Future.delayed(const Duration(milliseconds: 300));
     return [];
  }
}

