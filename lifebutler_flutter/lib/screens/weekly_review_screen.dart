import 'package:flutter/material.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import '../services/api_service.dart';

class WeeklyReviewScreen extends StatefulWidget {
  const WeeklyReviewScreen({super.key});

  @override
  State<WeeklyReviewScreen> createState() => _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends State<WeeklyReviewScreen> {
  bool _loading = true;
  List<Goal> _completedGoals = [];
  List<Goal> _missedGoals = [];
  
  // Future filtering logic
  Future<void> _fetchData() async {
    setState(() => _loading = true);
    
    // FETCH ALL GOALS (Simulating filtered query)
    final goals = await ApiService.getGoals();
    final now = DateTime.now();
    final oneWeekAgo = now.subtract(const Duration(days: 7));
    
    final recentGoals = goals.where((g) {
      // Logic: Period ended recently, OR it completed recently
      if (g.periodEnd.isBefore(now) && g.periodEnd.isAfter(oneWeekAgo)) return true;
      if (g.lastCompletedAt != null && g.lastCompletedAt!.isAfter(oneWeekAgo)) return true;
      return false;
    }).toList();
    
    _completedGoals = recentGoals.where((g) => g.completedCount >= g.targetCount).toList();
    _missedGoals = recentGoals.where((g) => g.completedCount < g.targetCount && g.periodEnd.isBefore(now)).toList();
    
    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Widget _buildGoalTile(Goal goal, ThemeData theme, {bool isWin = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: isWin ? Border.all(color: Colors.amber.withValues(alpha: 0.3)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Icon(isWin ? Icons.emoji_events : Icons.timer_off_outlined, 
                    color: isWin ? Colors.amber : Colors.grey, size: 20),
               const SizedBox(width: 12),
               Expanded(child: Text(goal.title, style: theme.textTheme.titleMedium)),
            ],
          ),
          if (!isWin) ...[
             const SizedBox(height: 8),
             Text("Target: ${goal.completedCount}/${goal.targetCount}", style: theme.textTheme.bodySmall),
             // Placeholder for reflection snippet (since we can't easily fetch it yet due to endpoint issues)
             const SizedBox(height: 8),
             Container(
               padding: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                 color: theme.colorScheme.surface.withValues(alpha: 0.5),
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Text("Reflection: It was a busy week...", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
             ),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Weekly Review'),
        backgroundColor: Colors.transparent,
      ),
      body: _loading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // INTRO
            Text("Past 7 Days", style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
            const SizedBox(height: 8),
            Text("Review Your Week", style: theme.textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text("Take a moment to celebrate wins and learn from misses.", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            
            const SizedBox(height: 32),
            
            // WINS
            if (_completedGoals.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber), 
                  const SizedBox(width: 8), 
                  Text("Wins (${_completedGoals.length})", style: theme.textTheme.titleLarge)
                ],
              ),
              const SizedBox(height: 16),
              ..._completedGoals.map((g) => _buildGoalTile(g, theme, isWin: true)),
            ] else 
              if (_missedGoals.isNotEmpty) // If missed goals exist but no wins
                 Text("No wins this week loop. Keep pushing!", style: TextStyle(color: Colors.grey)),

            
            const SizedBox(height: 32),
            
            // MISSED
            if (_missedGoals.isNotEmpty) ...[
               Text("Missed Goals", style: theme.textTheme.titleLarge),
               const SizedBox(height: 16),
               ..._missedGoals.map((g) => _buildGoalTile(g, theme, isWin: false)),
            ],
            
            const SizedBox(height: 32),
            
            // NEXT WEEK FOCUS
            Text("Focus for Next Week", style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "What is your #1 priority?",
                filled: true,
                fillColor: theme.cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              maxLines: 2,
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Complete Review"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
