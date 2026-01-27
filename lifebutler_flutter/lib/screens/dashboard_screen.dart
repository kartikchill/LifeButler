import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../widgets/goal_card.dart';
import '../widgets/hero_progress_card.dart';
import 'add_goal_screen.dart';
import 'review_screen.dart';
import '../utils/streak_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  late Future<List<Goal>> goalsFuture;
  int _selectedSegment = 0; // 0: Active, 1: Expired

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint('📱 App resumed - Refreshing schedules...');
      // Clean slate schedule refresh to ensure no old alarms are hanging around
      if (goalsFuture != null) {
          goalsFuture.then((goals) {
               NotificationService().refreshAllSchedules(goals); 
          });
      }

    }
  }

  void refresh() {
    setState(() {
      goalsFuture = ApiService.getGoals().then((goals) async {
        // Evaluate Streaks
        await StreakManager.evaluateAndUpdate(goals);

        // Run notification sync only when data is fetched
        debugPrint('🔄 AUTO-SYNC: Refreshing notification checks (Once)');
        NotificationService().refreshAllSchedules(goals);
        


        // Auto-switch logic (prioritize Active -> Completed -> Expired)
        final now = DateTime.now();
        final hasActive = goals.any((g) => g.completedCount < g.targetCount && g.periodEnd.isAfter(now));
        final hasCompleted = goals.any((g) => g.completedCount >= g.targetCount);
        final hasExpired = goals.any((g) => g.completedCount < g.targetCount && g.periodEnd.isBefore(now));
        
        if (!hasActive && mounted) {
           WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                if (hasCompleted) {
                   setState(() => _selectedSegment = 1);
                } else if (hasExpired) {
                   setState(() => _selectedSegment = 2);
                }
              }
           });
        }

        return goals;
      });
    });
  }

  // Calculate overall progress for the ring
  double _calculateOverallProgress(List<Goal> goals) {
    if (goals.isEmpty) return 0.0;
    int totalTarget = 0;
    int totalCompleted = 0;
    for (var g in goals) {
      totalTarget += g.targetCount;
      // Cap at target for the ring, or allow bonus? User said "X% on track"
      // Usually "on track" implies capping at 100% per goal or overall.
      totalCompleted += (g.completedCount > g.targetCount) ? g.targetCount : g.completedCount; 
    }
    if (totalTarget == 0) return 0.0;
    return totalCompleted / totalTarget;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.black,
        elevation: 4,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddGoalScreen()),
          );
          refresh();
        },
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => refresh(),
          color: theme.primaryColor,
          backgroundColor: theme.cardColor,
          child: FutureBuilder<List<Goal>>(
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
                        Text('Connection Issue\n${snapshot.error}', textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
                        const SizedBox(height: 24),
                        ElevatedButton(onPressed: refresh, child: const Text('Retry')),
                      ],
                    ),
                  ),
                );
              }

              final goals = snapshot.data ?? [];
              final overallProgress = _calculateOverallProgress(goals);
              final progressPercent = (overallProgress * 100).toInt();
              
              final now = DateTime.now();
              // Logic: 
              // 1. Completed: Target Reached (regardless of time)
              // 2. Active: Target NOT reached AND Time NOT up
              // 3. Expired: Target NOT reached AND Time IS up
              
              final completedGoals = goals.where((g) => g.completedCount >= g.targetCount).toList();
              final activeGoals = goals.where((g) => g.completedCount < g.targetCount && g.periodEnd.isAfter(now)).toList();
              final expiredGoals = goals.where((g) => g.completedCount < g.targetCount && g.periodEnd.isBefore(now)).toList();
              
              final displayedGoals = _selectedSegment == 0 
                  ? activeGoals 
                  : (_selectedSegment == 1 ? completedGoals : expiredGoals);

              return CustomScrollView(
                slivers: [
                  // 1. Header & Summary Ring
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          // Top Row: Greeting + Weekly Review
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getGreeting(),
                                    style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Make today count.',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewScreen())),
                                icon: const Icon(Icons.insights),
                                tooltip: 'Weekly Review',
                                style: IconButton.styleFrom(
                                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                  foregroundColor: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),
                          
                          // Hero Progress Summary
                          HeroProgressCard(
                            progress: overallProgress, 
                            completedSessions: _countTotalCompleted(goals),
                          ),
                          
                          const SizedBox(height: 16),
                          Center(
                            child: Text(
                              _getDailyMotivation(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Commitments Section
                          Text('Commitments', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 16),
                          
                          // Custom Segmented Control (Pill Style)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                _buildSegmentItem('Active', 0, theme),
                                _buildSegmentItem('Done', 1, theme),
                                _buildSegmentItem('Expired', 2, theme),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 2. Goal List
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 80),
                    sliver: displayedGoals.isEmpty
                        ? SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _selectedSegment == 0 ? Icons.spa_outlined : (_selectedSegment == 1 ? Icons.emoji_events_outlined : Icons.history), 
                                    size: 48, 
                                    color: theme.disabledColor
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _getEmptyStateMessage(), 
                                    style: theme.textTheme.bodyMedium
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return GoalCard(goal: displayedGoals[index], onRefresh: refresh);
                              },
                              childCount: displayedGoals.length,
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentItem(String label, int index, ThemeData theme) {
    final isSelected = _selectedSegment == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _selectedSegment = index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: isSelected ? Colors.black : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 18) return 'Good Afternoon,';
    return 'Good Evening,';
  }

  String _getDailyMotivation() {
    final quotes = [
      "You’re building consistency.",
      "Momentum looks strong this week.",
      "One session today keeps the streak alive.",
      "Discipline is choosing what you want most over what you want now.",
      "Small steps every day."
    ];
    return quotes[DateTime.now().day % quotes.length];
  }

  int _countTotalCompleted(List<Goal> goals) {
    if (goals.isEmpty) return 0;
    return goals.map((g) => g.completedCount).reduce((a, b) => a + b);
  }

  String _getEmptyStateMessage() {
    switch (_selectedSegment) {
      case 0: return 'No active commitments.';
      case 1: return 'No completed goals yet.';
      case 2: return 'No expired commitments.';
      default: return '';
    }
  }
}
