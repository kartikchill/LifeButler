import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class GoalEndpoint extends Endpoint {
  Future<Goal> createGoal(
    Session session, {
    required int userId,
    required String title,
    String? description,
  }) async {
    final goal = Goal(
      userId: userId,
      title: title,
      description: description,
      isActive: true,
      createdAt: DateTime.now(),
    );

    await Goal.db.insertRow(session, goal);
    return goal;
  }

  Future<List<Goal>> getGoals(Session session, int userId) async {
    return await Goal.db.find(
      session,
      where: (g) => g.userId.equals(userId),
    );
  }
}
