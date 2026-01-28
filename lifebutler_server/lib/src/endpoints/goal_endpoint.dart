import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class GoalEndpoint extends Endpoint {
  Future<Goal> createGoal(
    Session session, {
    required int userId,
    required String title,
    String? description,
    String? affirmation,
    int targetCount = 1,
    String periodType = 'week',
    String? consistencyStyle, 
    DateTime? anchorTime,
    int? priority, // 1=High, 2=Medium, 3=Low
  }) async {
    final now = DateTime.now();
    
    DateTime periodStart;
    DateTime periodEnd;

    if (periodType == 'month') {
      periodStart = now;
      periodEnd = now.add(const Duration(days: 30));
    } else {
      periodStart = now;
      periodEnd = now.add(const Duration(days: 7));
    }
    
    // Default to Medium (2) if not provided
    final finalPriority = priority ?? 2;

    final goal = Goal(
      userId: userId,
      title: title,
      description: description,
      affirmation: affirmation,
      isActive: true,
      createdAt: now,
      targetCount: targetCount,
      completedCount: 0,
      periodType: periodType,
      periodStart: periodStart,
      periodEnd: periodEnd,
      lastCompletedAt: null,
      consistencyStyle: consistencyStyle,
      anchorTime: anchorTime,
      priority: finalPriority,
    );

    final insertedGoal = await Goal.db.insertRow(session, goal);
    return insertedGoal;
  }

  Future<Goal> completeGoalSession(Session session, int goalId) async {
    final goal = await Goal.db.findById(session, goalId);
    if (goal == null) {
      throw Exception('Goal not found');
    }

    final now = DateTime.now();
    bool isExpired = now.isAfter(goal.periodEnd);
    bool isFirstCompletion = goal.lastCompletedAt == null;

    if (isExpired) {
      throw Exception('Challenge has expired. Start a new one!');
    }
    
    // Constraint removed: Allow over-completion (e.g. 11/10)
    // if (goal.completedCount >= goal.targetCount) { ... }
    
    // Cooldown Validation (12 hours)
    if (!isFirstCompletion && goal.lastCompletedAt != null) {
       final timeSinceLast = now.difference(goal.lastCompletedAt!);
       if (timeSinceLast.inHours < 12) {
         final waitTime = Duration(hours: 12) - timeSinceLast;
         final hours = waitTime.inHours;
         final minutes = waitTime.inMinutes % 60;
         throw Exception('Cooldown active. Next session in ${hours}h ${minutes}m');
       }
    }
    
    if (isFirstCompletion) {
       // Optional: Could log start of challenge here if needed
    }

    goal.completedCount++;
    goal.lastCompletedAt = now;

    await Goal.db.updateRow(session, goal);
    return goal;
  }

  Future<Goal> restartGoal(Session session, int goalId) async {
    final goal = await Goal.db.findById(session, goalId);
    if (goal == null) {
      throw Exception('Goal not found');
    }

    final now = DateTime.now();
    goal.periodStart = now;
    if (goal.periodType == 'month') {
      goal.periodEnd = now.add(const Duration(days: 30));
    } else {
      goal.periodEnd = now.add(const Duration(days: 7));
    }
    goal.completedCount = 0;
    goal.lastCompletedAt = null;

    await Goal.db.updateRow(session, goal);
    return goal;
  }

  Future<List<Goal>> getGoals(Session session, int userId) async {
    return await Goal.db.find(
      session,
      where: (g) => g.userId.equals(userId),
      orderByList: (t) => [
        Order(column: t.priority, orderDescending: false), // High (1) -> Low (3)
        Order(column: t.periodEnd, orderDescending: false),
        Order(column: t.createdAt, orderDescending: true),
      ],
    );
  }
  Future<bool> updateGoal(Session session, Goal goal) async {
    await Goal.db.updateRow(session, goal);
    return true;
  }
}
