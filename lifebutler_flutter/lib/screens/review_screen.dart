import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import '../services/api_service.dart';

enum ReviewMode { weekly, monthly }

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ReviewMode _mode = ReviewMode.weekly;
  DateTime _focusedDate = DateTime.now(); // For monthly navigation
  bool _loading = true;
  
  Map<String, List<Goal>> _groupedWins = {};
  List<Goal> _missedGoals = [];
  List<Goal> _affirmationGoals = [];
  
  // Stats for Monthly
  int _totalSessions = 0;
  int _totalCompletedGoals = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() => _loading = true);
    
    // FETCH ALL GOALS
    final allGoals = await ApiService.getGoals();
    final now = DateTime.now();
    
    DateTime start;
    DateTime end;

    if (_mode == ReviewMode.weekly) {
      end = now;
      start = now.subtract(const Duration(days: 7));
    } else {
      // Monthly: Start of selected month to end of selected month
      start = DateTime(_focusedDate.year, _focusedDate.month, 1);
      // End date is start of next month
      end = DateTime(_focusedDate.year, _focusedDate.month + 1, 1).subtract(const Duration(seconds: 1));
    }

    // STRICT FILTERING LOGIC
    
    // 0. Prevent Future Data
    if (start.isAfter(now)) {
       setState(() {
         _groupedWins = {};
         _missedGoals = [];
         _affirmationGoals = [];
         _totalCompletedGoals = 0;
         _totalSessions = 0;
         _loading = false;
       });
       return;
    }

    // 1. Process Wins (Completed Goals)
    // Constraint: Must be completed AND completion time must be within the selected window.
    final wins = allGoals.where((g) {
      if (g.completedCount < g.targetCount) return false;
      if (g.lastCompletedAt == null) return false;
      return g.lastCompletedAt!.isAfter(start) && g.lastCompletedAt!.isBefore(end.add(const Duration(days: 1)));
    }).toList();
    
    // Group Wins by Title
    _groupedWins = {};
    for (var win in wins) {
      if (!_groupedWins.containsKey(win.title)) {
        _groupedWins[win.title] = [];
      }
      _groupedWins[win.title]!.add(win);
    }

    // 2. Process Missed (Expired but not completed)
    // Constraint: Ends in this window AND target not reached.
    _missedGoals = allGoals.where((g) {
       if (g.completedCount >= g.targetCount) return false;
       return g.periodEnd.isAfter(start) && g.periodEnd.isBefore(end.add(const Duration(days: 1)));
    }).toList();

    // 3. Process Monthly Affirmations (Strict attribution)
    if (_mode == ReviewMode.monthly) {
       _affirmationGoals = allGoals.where((g) {
          // Rule 1: If Completed, MUST use completion date.
          if (g.completedCount >= g.targetCount) {
             return g.lastCompletedAt != null && 
                    g.lastCompletedAt!.isAfter(start) && 
                    g.lastCompletedAt!.isBefore(end.add(const Duration(days: 1)));
          }
          
          // Rule 2: If Active/Missed, use periodEnd as proxy for "This Month's Goal"
          // We include it if it expires/ends in this month.
          return g.periodEnd.isAfter(start) && g.periodEnd.isBefore(end.add(const Duration(days: 7))); 
       }).toList();
       
       // Sort: Completed -> In Progress -> Missed
       _affirmationGoals.sort((a, b) {
          final aDone = a.completedCount >= a.targetCount ? 0 : 1;
          final bDone = b.completedCount >= b.targetCount ? 0 : 1;
          return aDone.compareTo(bDone);
       });
    } else {
      _affirmationGoals = [];
    }
    
    // Calculate Stats
    _totalCompletedGoals = wins.length;
    // For sessions, we only count sessions of goals active/completed in this period.
    // For accuracy, we just sum completedCount of matches.
    _totalSessions = wins.fold(0, (sum, g) => sum + g.completedCount) + _missedGoals.fold(0, (sum, g) => sum + g.completedCount);
    


    setState(() => _loading = false);
  }

  void _onModeChanged(ReviewMode mode) {
    HapticFeedback.selectionClick();
    setState(() {
      _mode = mode;
      _focusedDate = DateTime.now(); // Reset date when switching
    });
    _fetchData();
  }
  
  void _changeMonth(int offset) {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + offset, 1);
    });
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final isWeekly = _mode == ReviewMode.weekly;
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Review', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. TOGGLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  _buildToggleItem('Weekly', ReviewMode.weekly, theme),
                  _buildToggleItem('Monthly', ReviewMode.monthly, theme),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          _loading 
            ? const Expanded(child: Center(child: CircularProgressIndicator())) 
            : Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // 2. HEADER
                      _buildHeader(theme),
                      const SizedBox(height: 32),
                      
                      // 3. SUMMARY (Monthly Only)
                      if (!isWeekly) ...[
                        _buildMonthlySummary(theme),
                        const SizedBox(height: 32),
                        
                        // 3.5 Affirmations Recap
                        _buildSectionHeader('Your Affirmations', _affirmationGoals.length, theme, icon: Icons.psychology, color: Colors.purple.shade300),
                        Padding(
                          padding: const EdgeInsets.only(left: 36, bottom: 16),
                          child: Text(
                            "These were the promises you reminded yourself of.",
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        ),
                        if (_affirmationGoals.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("No affirmations yet for this month.", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Text("Start a commitment to build one.", style: theme.textTheme.bodySmall?.copyWith(color: theme.primaryColor)),
                                ],
                              ),
                            ),
                          )
                        else
                          ..._affirmationGoals.map((g) => _buildAffirmationCard(g, theme)),
                        
                        const SizedBox(height: 40),
                      ],

                      // 4. WINS
                      _buildSectionHeader('Wins', _totalCompletedGoals, theme, icon: Icons.emoji_events, color: Colors.amber),
                      if (_groupedWins.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text("No wins recorded for this period yet.", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                        )
                      else
                        ..._groupedWins.entries.map((entry) => _buildWinGroup(entry.key, entry.value, theme)),
                      
                      const SizedBox(height: 32),
                      
                      // 5. MISSED
                      if (_missedGoals.isNotEmpty) ...[
                         _buildSectionHeader('Missed Opportunities', _missedGoals.length, theme, icon: Icons.history, color: Colors.grey),
                         ..._missedGoals.map((g) => _buildMissedCard(g, theme)),
                      ],
                      
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
  
  Widget _buildToggleItem(String label, ReviewMode mode, ThemeData theme) {
    final isSelected = _mode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onModeChanged(mode),
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
  
  Widget _buildHeader(ThemeData theme) {
    final isWeekly = _mode == ReviewMode.weekly;
    
    if (isWeekly) {
      final now = DateTime.now();
      final sevenDaysAgo = now.subtract(const Duration(days: 7));
      final dateFormat = DateFormat('MMM d');
      
      return Column(
        children: [
          Text(
            "Past 7 Days",
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.primaryColor, 
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${dateFormat.format(sevenDaysAgo)} – ${dateFormat.format(now)}",
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Take a moment to reflect on your wins.",
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      // Monthly Header with Selectors
      final monthFormat = DateFormat('MMMM yyyy');
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () => _changeMonth(-1), icon: const Icon(Icons.arrow_back_ios, size: 16)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  monthFormat.format(_focusedDate),
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(onPressed: () => _changeMonth(1), icon: const Icon(Icons.arrow_forward_ios, size: 16)),
            ],
          ),
           const SizedBox(height: 8),
           Text(
            "Your month in review.",
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      );
    }
  }

  Widget _buildMonthlySummary(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            theme, 
            "$_totalSessions", 
            "Sessions", 
            Icons.check_circle_outline,
            theme.primaryColor
          )
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            theme, 
            "$_totalCompletedGoals", 
            "Completed", 
            Icons.emoji_events_outlined,
            Colors.amber
          )
        ),
      ],
    );
  }
  
  Widget _buildSummaryCard(ThemeData theme, String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count, ThemeData theme, {required IconData icon, required Color color}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Text("$title ($count)", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
  
  Widget _buildWinGroup(String title, List<Goal> goals, ThemeData theme) {
    // We stack them visually. The group is the "Win".
    // If multiple, show indicators.
    final lastGoal = goals.last;
    final dateStr = lastGoal.lastCompletedAt != null 
        ? DateFormat('MMM d').format(lastGoal.lastCompletedAt!) 
        : "Recently";

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
             color: Colors.amber.withValues(alpha: 0.05),
             blurRadius: 10,
             offset: const Offset(0, 4),
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           // Trophy Icon Container
           Container(
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
               color: Colors.amber.withValues(alpha: 0.1),
               shape: BoxShape.circle,
             ),
             child: const Icon(Icons.emoji_events, color: Colors.amber, size: 24),
           ),
           const SizedBox(width: 16),
           
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   title, 
                   style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                 ),
                 const SizedBox(height: 4),
                 if (lastGoal.affirmation != null || true) // Always show (fallback)
                    Padding(
                       padding: const EdgeInsets.only(bottom: 4),
                       child: Text(
                         lastGoal.affirmation?.isNotEmpty == true ? lastGoal.affirmation! : "I show up even when I don't feel like it.",
                         style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: theme.primaryColor),
                       ),
                    ),
                 // If grouped > 1, show "x3 completions"
                 if (goals.length > 1) 
                    Text(
                      "${goals.length} completions • Last on $dateStr",
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                    )
                 else
                    Text(
                      "Completed on $dateStr",
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
               ],
             ),
           ),
        ],
      ),
    );
  }
  
  Widget _buildAffirmationCard(Goal goal, ThemeData theme) {
    final bool isCompleted = goal.completedCount >= goal.targetCount;
    final bool isExpired = DateTime.now().isAfter(goal.periodEnd) && !isCompleted;
    
    // Status Config
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.hourglass_empty;
    String statusText = "In Progress";
    
    if (isCompleted) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      statusText = "Completed";
    } else if (isExpired) {
      statusColor = Colors.red.shade300;
      statusIcon = Icons.cancel;
      statusText = "Missed";
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.05)),
         boxShadow: [
          BoxShadow(
             color: Colors.black.withOpacity(0.05),
             blurRadius: 8,
             offset: const Offset(0, 2),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Affirmation Text
          Text(
            goal.affirmation?.isNotEmpty == true ? goal.affirmation! : "I show up even when I don't feel like it.",
            style: theme.textTheme.titleMedium?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.4,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Divider(height: 1, color: theme.dividerColor.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          
          // Footer: Goal Title + Status
          Row(
            children: [
              Expanded(
                child: Text(
                  goal.title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 12, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      statusText,
                      style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMissedCard(Goal goal, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
           Icon(Icons.history, color: Colors.grey, size: 20),
           const SizedBox(width: 16),
           Expanded(
             child: Text(
               goal.title,
               style: theme.textTheme.bodyMedium?.copyWith(
                 decoration: TextDecoration.lineThrough,
                 color: theme.disabledColor,
               ),
             ),
           ),
        ],
      ),
    );
  }
}
