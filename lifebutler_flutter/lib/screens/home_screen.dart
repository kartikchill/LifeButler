import 'package:flutter/material.dart';
import 'goals_list_screen.dart';
import '../widgets/progress_ring.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LifeButler')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: const [
                    ProgressRing(progress: 0.65),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'You’re doing great!\n65% goals on track',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GoalsListScreen(),
                      ),
                    );
                  },
                  child: const Text('View Goals'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
