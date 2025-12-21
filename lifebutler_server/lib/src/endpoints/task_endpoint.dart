import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class TaskEndpoint extends Endpoint {
  Future<void> completeTask(
    Session session, {
    required int taskId,
  }) async {
    final completion = TaskCompletion(
      taskId: taskId,
      completedAt: DateTime.now(),
    );

    await TaskCompletion.db.insertRow(session, completion);
  }
}
