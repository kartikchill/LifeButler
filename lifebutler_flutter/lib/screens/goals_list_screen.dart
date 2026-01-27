import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/goal_card.dart';
import 'add_goal_screen.dart';

class GoalsListScreen extends StatefulWidget {
  const GoalsListScreen({super.key});

  @override
  State<GoalsListScreen> createState() => _GoalsListScreenState();
}

class _GoalsListScreenState extends State<GoalsListScreen> {
  late Future goalsFuture;

  @override
  void initState() {
    super.initState();
    goalsFuture = ApiService.getGoals();
  }

  void refresh() {
    setState(() {
      goalsFuture = ApiService.getGoals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Goals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddGoalScreen(),
                ),
              );
              refresh();
            },
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: goalsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Unable to load goals.\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: refresh,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final goals = snapshot.data as List? ?? [];

            if (goals.isEmpty) {
              return const Center(child: Text('No goals yet. Create one!'));
            }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return GoalCard(goal: goals[index]);
            },
          );
        },
      ),
      ),
    );
  }
}
