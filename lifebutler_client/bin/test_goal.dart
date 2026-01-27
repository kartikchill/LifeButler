import 'package:lifebutler_client/lifebutler_client.dart';

void main() async {
  final client = Client(
    'http://localhost:8080',
  );

  final goal = await client.goal.createGoal(
    userId: 1,
    title: 'First Goal',
    description: 'Testing Serverpod',
  );

  print('Created goal: ${goal.id} ${goal.title}');

  final goals = await client.goal.getGoals(1);
  print('Fetched goals count: ${goals.length}');
}
