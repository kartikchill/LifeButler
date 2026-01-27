import 'package:flutter/material.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import '../screens/add_goal_screen.dart';
import 'reflection_dialog.dart';

class GoalSummaryDialog extends StatelessWidget {
  final Goal goal;
  final VoidCallback? onRefresh;

  const GoalSummaryDialog({super.key, required this.goal, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = goal.completedCount >= goal.targetCount;
    
    return AlertDialog(
      backgroundColor: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            isCompleted ? Icons.emoji_events : Icons.timer_off_outlined,
            size: 48,
            color: isCompleted ? Colors.amber : Colors.grey,
          ),
          const SizedBox(height: 16),
          
          // Title
          Text(
            isCompleted ? 'Goal Completed!' : 'Goal Expired',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.amber : theme.disabledColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            goal.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          
          // Stats
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(context, 'Target', '${goal.targetCount}'),
                Container(width: 1, height: 24, color: theme.dividerColor),
                _buildStat(context, 'Completed', '${goal.completedCount}'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Actions
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.edit_note),
              label: const Text("Reflect"),
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context, 
                  builder: (_) => ReflectionDialog(goal: goal, isCompleted: isCompleted)
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("Recommit"),
              onPressed: () async {
                 Navigator.pop(context);
                 await Navigator.push(
                   context, 
                   MaterialPageRoute(builder: (_) => AddGoalScreen(templateGoal: goal))
                 );
                 onRefresh?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor)),
      ],
    );
  }
}
