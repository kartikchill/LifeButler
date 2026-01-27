import 'package:lifebutler_client/lifebutler_client.dart';
import '../services/api_service.dart';

class StreakManager {
  
  /// Evaluates and updates streaks for a list of goals.
  /// Returns the number of goals updated.
  static Future<int> evaluateAndUpdate(List<Goal> goals, {
    Future<bool> Function(Goal)? onUpdate,
  }) async {
    int updatedCount = 0;
    final now = DateTime.now();

    for (var goal in goals) {
      bool changed = false;
      
      // Initialize if null
      goal.currentStreak ??= 0;
      goal.longestStreak ??= 0;

      // Check 1: Has the period ended?
      if (goal.periodEnd.isBefore(now)) {
        // Check 2: Have we already evaluated this specific period?
        // We use lastEvaluatedPeriodEnd to avoid double-counting the same period.
        // We ignore millisecond differences by checking < 1 minute diff or exact equality logic if needed.
        // Simple check: if lastEvaluated == periodEnd, skip.
        
        bool alreadyEvaluated = false;
        if (goal.lastEvaluatedPeriodEnd != null) {
           // Check if it's the same moment (within 1 second tolerance)
           if (goal.lastEvaluatedPeriodEnd!.difference(goal.periodEnd).abs().inSeconds < 5) {
             alreadyEvaluated = true;
           }
        }

        if (!alreadyEvaluated) {
          // EVALUATE NOW
          final bool success = goal.completedCount >= goal.targetCount;
          
          if (success) {
            goal.currentStreak = (goal.currentStreak ?? 0) + 1;
            if ((goal.currentStreak ?? 0) > (goal.longestStreak ?? 0)) {
              goal.longestStreak = goal.currentStreak;
            }
          } else {
             // Failure - Reset Strike
             // "Streaks reset cleanly on failure"
             goal.currentStreak = 0;
          }
          
          goal.lastEvaluatedPeriodEnd = goal.periodEnd;
          changed = true;
        }
      }
      
      // Check 3: Daily Anchor Special Case (Strict Daily)
      // "Daily Anchor: Missing a day breaks streak."
      // We need to check if they missed YESTERDAY.
      if (goal.consistencyStyle == 'dailyAnchor' && goal.anchorTime != null) {
         // Logic: If lastCompletedAt was BEFORE yesterday (i.e. > 24+ hours ago overlap), break streak?
         // Simpler: If today is T, and lastCompletedAt is T-2, they missed T-1.
         // We only reset if they missed a day. We don't increment here (increment is handled by period logic? No, Daily Anchor usually increments DAILY?)
         // User said: "Daily Anchor... Requires at least 1 session per day... Missing a day breaks streak."
         
         // If `currentStreak` represents "Days" for daily goals, we should increment it daily?
         // User said: "Streaks are evaluated per goal... Weekly goals... Monthly goals... Daily Anchor..."
         // If Daily Anchor is just a style of a "Monthly Goal", then streak is still Monthly?
         // "Streaks increment only when targets are met" -> Target is usually "Count / Period".
         // If a Daily Anchor goal has target=30, period=month, then streak is +1 MONTH.
         // BUT "Missing a day breaks streak" implies intermediate checks.
         //
         // INTERPRETATION: 
         // Daily Anchor goals likely have high target counts matching days in month? 
         // OR, the User implies a separate "Daily Streak" for them.
         // "Daily Anchor behaves like a strict streak mode".
         
         // Let's stick to the period evaluation for +1 increment, but RESET if they miss a day.
         
         if (goal.lastCompletedAt != null) {
            final last = goal.lastCompletedAt!;
            final diff = now.difference(last).inDays;
            if (diff > 1) {
               // Missed more than 1 day (e.g. 2 days ago was last complete)
               // Reset immediately
               if ((goal.currentStreak ?? 0) > 0) {
                 goal.currentStreak = 0;
                 changed = true;
               }
            }
         } else {
            // Never completed? 
            // If created > 1 day ago, reset.
            if (now.difference(goal.createdAt).inDays > 1 && (goal.currentStreak ?? 0) > 0) {
              goal.currentStreak = 0;
              changed = true;
            }
         }
      }

      if (changed) {
        if (onUpdate != null) {
          await onUpdate(goal);
        } else {
          await ApiService.updateGoal(goal);
        }
        updatedCount++;
      }
    }
    
    return updatedCount;
  }
}
