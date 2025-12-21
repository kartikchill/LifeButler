import 'package:flutter/material.dart';
import 'config/serverpod_client.dart';

void main() {
  client = createClient();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LifeButler')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final goal = await client.goal.createGoal(
              userId: 1,
              title: 'Study DSA',
              description: 'Daily practice',
            );

            debugPrint('Created goal: ${goal.title}');
          },
          child: const Text('Create Goal'),
        ),
      ),
    );
  }
}
