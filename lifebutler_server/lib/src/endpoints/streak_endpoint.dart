import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StreakEndpoint extends Endpoint {
  Future<Streak> updateStreak(
    Session session, {
    required int goalId,
  }) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final existing = await Streak.db.findFirstRow(
      session,
      where: (s) => s.goalId.equals(goalId),
    );

    if (existing == null) {
      final streak = Streak(
        goalId: goalId,
        currentStreak: 1,
        bestStreak: 1,
        lastCompletedDate: today,
      );
      await Streak.db.insertRow(session, streak);
      return streak;
    }

    final last = existing.lastCompletedDate;
    final yesterday = today.subtract(const Duration(days: 1));

    if (last == yesterday) {
      existing.currentStreak += 1;
    } else if (last != today) {
      existing.currentStreak = 1;
    }

    if (existing.currentStreak > existing.bestStreak) {
      existing.bestStreak = existing.currentStreak;
    }

    existing.lastCompletedDate = today;

    await Streak.db.updateRow(session, existing);
    return existing;
  }
}
