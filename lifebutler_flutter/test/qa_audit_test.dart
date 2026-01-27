
import 'package:flutter_test/flutter_test.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import 'package:lifebutler_flutter/utils/streak_manager.dart';

void main() {
  group('QA Audit - Goal Logic & Integrity', () {
    
    // --- 1. Goal Creation & Defaults ---
    test('Goal Creation Defaults Logic (Server Simulation)', () {
      final now = DateTime.now();
      
      // Simulate Server Creation Logic 
      Goal createMockGoal(String periodType) {
        DateTime periodStart = now;
        DateTime periodEnd = periodType == 'month' 
            ? now.add(const Duration(days: 30)) 
            : now.add(const Duration(days: 7));
            
        return Goal(
          userId: 1, 
          title: 'Test Goal', 
          isActive: true, 
          createdAt: now, 
          targetCount: 5, 
          completedCount: 0, 
          periodType: periodType, 
          periodStart: periodStart, 
          periodEnd: periodEnd
        );
      }

      final weeklyGoal = createMockGoal('week');
      final monthlyGoal = createMockGoal('month');

      // Verify Durations
      expect(weeklyGoal.periodEnd.difference(weeklyGoal.periodStart).inDays, 7, reason: "Weekly goal should be 7 days");
      expect(monthlyGoal.periodEnd.difference(monthlyGoal.periodStart).inDays, 30, reason: "Monthly goal should be 30 days");
      
      // Verify Status
      expect(weeklyGoal.isActive, true);
      expect(weeklyGoal.completedCount, 0);
    });

    // --- 2. Session Completion & Cooldown (Server Logic Simulation) ---
    test('Session Completion & Cooldown Integrity', () async {
       // Mock Server Function
       void mockCompleteSession(Goal goal, DateTime serverTime) {
         bool isExpired = serverTime.isAfter(goal.periodEnd);
         if (isExpired) throw Exception("Expired");
         
         if (goal.completedCount >= goal.targetCount) throw Exception("Target reached");

         if (goal.lastCompletedAt != null) {
           final diff = serverTime.difference(goal.lastCompletedAt!);
           if (diff.inHours < 12) throw Exception("Cooldown active");
         }
         
         goal.completedCount++;
         goal.lastCompletedAt = serverTime;
       }

       final now = DateTime.now();
       final goal = Goal(
          userId: 1, title: 'Cooldown Test', isActive: true, createdAt: now, 
          targetCount: 10, completedCount: 0, 
          periodType: 'week', periodStart: now, periodEnd: now.add(const Duration(days: 7))
       );

       // 1. First Completion - Should Succeed
       mockCompleteSession(goal, now);
       expect(goal.completedCount, 1);
       expect(goal.lastCompletedAt, now);

       // 2. Rapid Fire Completion (1 sec later) - Should Fail (Cooldown)
       expect(
         () => mockCompleteSession(goal, now.add(const Duration(seconds: 1))),
         throwsA(isA<Exception>()),
         reason: "Should block rapid completions"
       );

       // 3. Completion after 11 hours - Should Fail
       expect(
         () => mockCompleteSession(goal, now.add(const Duration(hours: 11))), 
         throwsA(isA<Exception>()),
         reason: "Should block if < 12 hours"
       );

       // 4. Completion after 13 hours - Should Succeed
       final later = now.add(const Duration(hours: 13));
       mockCompleteSession(goal, later);
       expect(goal.completedCount, 2);
       expect(goal.lastCompletedAt, later);
    });

    // --- 3. Streak Logic (Client Side) ---
    test('Streak Logic - Increment on Success', () async {
      // Setup
      final now = DateTime.now();
      // Period ENDED yesterday
      final pastEnd = now.subtract(const Duration(days: 1));
      
      final goal = Goal(
        userId: 1, title: 'Streak Test', isActive: true, createdAt: now.subtract(const Duration(days: 30)),
        targetCount: 5, completedCount: 5, // Target Met!
        periodType: 'week', periodStart: now.subtract(const Duration(days: 8)), periodEnd: pastEnd,
        currentStreak: 2, longestStreak: 2
      );

      bool updated = false;
      await StreakManager.evaluateAndUpdate([goal], onUpdate: (g) async {
        updated = true;
        return true;
      });

      expect(updated, true, reason: "Should trigger update");
      expect(goal.currentStreak, 3, reason: "Streak should increment to 3");
      expect(goal.longestStreak, 3, reason: "Longest streak should update");
      expect(goal.lastEvaluatedPeriodEnd, pastEnd, reason: "Should mark period as evaluated");
      
      // Re-run - Should NOT update again (Idempotency)
      updated = false;
      await StreakManager.evaluateAndUpdate([goal], onUpdate: (g) async {
        updated = true;
        return true;
      });
      expect(updated, false, reason: "Should not double-count streak for same period");
    });

    test('Streak Logic - Reset on Failure', () async {
      final now = DateTime.now();
      final pastEnd = now.subtract(const Duration(days: 1));
      
      final goal = Goal(
        userId: 1, title: 'Fail Test', isActive: true, 
        createdAt: now.subtract(const Duration(days: 30)),
        targetCount: 5, completedCount: 2, // FAILED (2/5)
        periodType: 'week', periodStart: now.subtract(const Duration(days: 8)), periodEnd: pastEnd,
        currentStreak: 5, longestStreak: 10
      );

      await StreakManager.evaluateAndUpdate([goal], onUpdate: (_) async => true);

      expect(goal.currentStreak, 0, reason: "Streak should reset to 0");
      expect(goal.longestStreak, 10, reason: "Longest streak should be preserved");
    });

    test('Streak Logic - Daily Anchor Strict Reset', () async {
       // Daily Anchor: Missing a day resets streak immediately
       final now = DateTime.now();
       
       final goal = Goal(
         userId: 1, title: 'Daily Anchor', isActive: true, 
         createdAt: now.subtract(const Duration(days: 10)),
         targetCount: 30, completedCount: 10,
         periodType: 'month', periodStart: now.subtract(const Duration(days: 10)), periodEnd: now.add(const Duration(days: 20)),
         consistencyStyle: 'dailyAnchor',
         anchorTime: DateTime(2025, 1, 1, 8, 0), // 8 AM
         currentStreak: 5,
         // Last completed 2 days ago = MISSED YESTERDAY
         lastCompletedAt: now.subtract(const Duration(days: 2)), 
       );

       await StreakManager.evaluateAndUpdate([goal], onUpdate: (_) async => true);
       
       expect(goal.currentStreak, 0, reason: "Daily Anchor should reset if missed yesterday");
    });
    
  });
}
