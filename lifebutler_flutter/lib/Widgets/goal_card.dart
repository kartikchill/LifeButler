import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import '../screens/goal_celebration_screen.dart';
import '../screens/add_goal_screen.dart';
import 'reflection_dialog.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../utils/quotes.dart';
import 'goal_summary_dialog.dart';

class GoalCard extends StatefulWidget {
  final Goal goal;
  final VoidCallback? onRefresh;

  const GoalCard({super.key, required this.goal, this.onRefresh});

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> with TickerProviderStateMixin {
  late Goal goal;
  bool loading = false;
  
  late AnimationController _cardAnimationController;
  late Animation<double> _scaleAnimation;
  
  String? _activeQuote;
  bool _showQuote = false;
  
  int? _optimisticCompletedCount;
  bool _isReverting = false;
  Timer? _cooldownTimer;


  @override
  void initState() {
    super.initState();
    goal = widget.goal;
    
    _cardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    
    _setupScaleAnimation();
    _startCooldownTimer();
  }

  void _startCooldownTimer() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
       if (mounted) setState(() {});
    });
  }

  void _setupScaleAnimation() {
     _cardAnimationController.duration = const Duration(milliseconds: 200);
     _scaleAnimation = TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.03).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 1.03, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 50),
      ]).animate(_cardAnimationController);
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(GoalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal && !_isReverting) {
      goal = widget.goal;
      if (_optimisticCompletedCount != null && goal.completedCount == _optimisticCompletedCount) {
         _optimisticCompletedCount = null;
      }
    }
  }

  void _showCinematicCelebration() {
    if (!mounted) return;
    
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Celebration",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => CinematicCelebrationOverlay(),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
    );
  }

  Widget _buildStreakBadge(ThemeData theme) {
     // CORE LOGIC CHANGE: Streak = Current Cycle Progress
     // We map 'completedCount' directly to 'Streak Days'. 
     
     final int currentProgress = widget.goal.completedCount;
     
     // 1. Guard: If no progress in current cycle, show nothing (or 0?)
     // User said "Show streak only if Streak > 0"
     if (currentProgress <= 0) return const SizedBox.shrink();
     
     String label;
     final isWeekly = widget.goal.periodType == 'week';
     
     // 2. Clamp Logic
     if (isWeekly) {
       // Max 7 days
       final effectiveStreak = currentProgress > 7 ? 7 : currentProgress;
       label = '$effectiveStreak Day Streak';
     } else {
       // Monthly - Max 30 days (simplified)
       // If 30/30 (or more), show "1 Month Streak"
       if (currentProgress >= 30) {
         label = '1 Month Streak';
       } else {
         final effectiveStreak = currentProgress > 30 ? 30 : currentProgress;
         label = '$effectiveStreak Day Streak';
       }
     }
     
     return Container(
       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
       decoration: BoxDecoration(
         gradient: LinearGradient(
           colors: [Colors.orange.shade400, Colors.deepOrange.shade600],
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
         ),
         borderRadius: BorderRadius.circular(20),
         boxShadow: [
           BoxShadow(
             color: Colors.orange.withOpacity(0.4),
             blurRadius: 8,
             offset: const Offset(0, 4),
           ),
         ],
       ),
       child: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           const Icon(Icons.local_fire_department_rounded, size: 14, color: Colors.white),
           const SizedBox(width: 4),
           Text(
             label, 
             style: const TextStyle(
               color: Colors.white, 
               fontWeight: FontWeight.w800,
               fontSize: 12,
               letterSpacing: 0.5,
             )
           ),
         ],
       ),
     );
  }
  
  void _triggerSessionFeedback() {
    setState(() {
      _activeQuote = Quotes.getRandomQuote(QuoteType.session);
      _showQuote = true;
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) setState(() => _showQuote = false);
    });
  }

  Future<void> onComplete() async {
    if (loading) return;

    final currentCompleted = _optimisticCompletedCount ?? goal.completedCount;
    // Strict Guard: No bonus logic
    if (currentCompleted >= goal.targetCount) return;

    final isGoalCompletion = (currentCompleted + 1 == goal.targetCount);

    setState(() {
      _optimisticCompletedCount = currentCompleted + 1;
      _isReverting = false;
    });

    if (isGoalCompletion) {
      _showCinematicCelebration();
      HapticFeedback.heavyImpact();
    } else {
      _cardAnimationController.forward(from: 0.0);
      HapticFeedback.lightImpact();
      _triggerSessionFeedback();
    }
    
    try {
      final updated = await ApiService.completeSession(goal.id!);
      await NotificationService().scheduleCommitmentNotifications(updated);
      
      if (mounted) {
        setState(() {
          goal = updated;
          _optimisticCompletedCount = null;
        });
      }
    } catch (e) {
      if (mounted) {
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _isReverting = true;
          _optimisticCompletedCount = null; 
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Failed to update: $e')),
        );
      }
    }
  }

  String _getResetTimeLabel() {
     final now = DateTime.now();
     final diff = goal.periodEnd.difference(now);
     if (diff.isNegative) return 'Expired';
     if (diff.inDays >= 1) return 'Ends in ${diff.inDays} days';
     if (diff.inHours >= 1) return 'Ends in ${diff.inHours} hours';
     return 'Ends soon';
  }
  
  String _getPeriodLabel() {
     if (goal.periodType == 'week') return '7-Day Challenge';
     if (goal.periodType == 'month') return '30-Day Challenge';
     return 'Challenge';
  }

  String get _affirmationText {
    final text = goal.affirmation;
    if (text == null || text.isEmpty) {
      return "I show up even when I don't feel like it.";
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final platform = theme.platform;
    final isIOS = platform == TargetPlatform.iOS;
    
    final completed = _optimisticCompletedCount ?? goal.completedCount;
    final target = goal.targetCount;
    
    // STATES
    final bool isTargetMet = completed >= target;
    final bool isExpired = DateTime.now().isAfter(goal.periodEnd);
    
    final cooldownParams = _getCooldownParams();
    final bool isCooldown = cooldownParams != null;
    
    // VISUAL STYLE DETERMINATION
    Color borderColor = Colors.transparent;
    Color glowColor = Colors.transparent;
    double opacity = 1.0;
    
    if (isTargetMet) {
      // SUCCESS STATE (Gold)
      borderColor = Colors.amber;
      glowColor = Colors.amber.withOpacity(0.3);
    } else if (isExpired) {
      // FAILED/EXPIRED STATE (Grey/Muted)
      opacity = 0.6;
    }

    final progressValue = (target > 0) ? (completed / target).clamp(0.0, 1.0) : 0.0;
    final primaryColor = theme.primaryColor;
    
    return Stack(
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: Opacity(
            opacity: opacity,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                border: isTargetMet ? Border.all(color: borderColor, width: 2) : null,
                boxShadow: [
                  BoxShadow(
                    color: isTargetMet ? glowColor : Colors.black.withOpacity(isIOS ? 0.2 : 0.3),
                    blurRadius: isTargetMet ? 12 : (isIOS ? 16 : 6),
                    offset: isIOS ? const Offset(0, 8) : const Offset(0, 4),
                  )
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: (isExpired || isTargetMet) ? () => showDialog(
                    context: context, 
                    builder: (_) => GoalSummaryDialog(goal: goal, onRefresh: widget.onRefresh)
                  ) : null,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  if (goal.priority == 1) 
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(Icons.priority_high, size: 18, color: Colors.orange),
                                    ),
                                  Expanded(child: Text(goal.title, style: theme.textTheme.titleLarge)),
                                ],
                              ),
                            ),
                            if (isTargetMet)
                              Icon(Icons.emoji_events, color: Colors.amber, size: 28)
                            else if (isExpired)
                              Icon(Icons.timer_off_outlined, color: Colors.grey, size: 24),
                          ],
                        ),
                        
                        // Affirmation (Active State)
                        if (!isExpired) ...[
                          const SizedBox(height: 4),
                          Text(
                            _affirmationText,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                        
                        const SizedBox(height: 24),
                        const SizedBox(height: 24),

                        // Progress Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Row(
                               children: [
                                  AnimatedSwitcher(
                                   duration: const Duration(milliseconds: 200),
                                   child: Text(
                                     '$completed',
                                     key: ValueKey('completed_$completed'),
                                     style: theme.textTheme.bodyMedium?.copyWith(
                                       fontSize: 15,
                                       fontWeight: FontWeight.bold, 
                                       color: isTargetMet ? Colors.amber : theme.colorScheme.onSurface
                                     ),
                                   ),
                                 ),
                                 Text(' / $target', style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15, color: theme.colorScheme.onSurface.withOpacity(0.5))),
                               ],
                             ),
                             Row(
                               children: [
                                  if ((widget.goal.currentStreak ?? 0) > 0)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: _buildStreakBadge(theme),
                                    ),
                                  Text(
                                    _getPeriodLabel(),
                                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                                  ),
                               ],
                             ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TweenAnimationBuilder<double>(
                           duration: const Duration(milliseconds: 600), 
                           curve: Curves.easeOutCubic,
                           tween: Tween<double>(begin: 0, end: progressValue),
                           builder: (context, val, _) => LinearProgressIndicator(
                             value: val,
                             minHeight: 12,
                             borderRadius: BorderRadius.circular(6),
                             backgroundColor: theme.colorScheme.surface.withOpacity(0.5),
                             valueColor: AlwaysStoppedAnimation<Color>(isTargetMet ? Colors.amber : primaryColor),
                           ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getResetTimeLabel(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: isExpired && !isTargetMet ? Colors.red.shade300 : theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                        
                        const SizedBox(height: 24),

                        // ACTION BUTTON / STATE LABEL
                        _buildActionButtons(isTargetMet, isExpired, isCooldown, cooldownParams, primaryColor),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        
        // Internal Quote Overlay
        if (_showQuote && _activeQuote != null)
           Positioned.fill(
             child: IgnorePointer(
               child: AnimatedOpacity(
                 opacity: _showQuote ? 1.0 : 0.0,
                 duration: const Duration(milliseconds: 400),
                 child: Container(
                   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                   decoration: BoxDecoration(
                     color: Colors.black.withOpacity(0.85),
                     borderRadius: BorderRadius.circular(24),
                   ),
                   alignment: Alignment.center,
                   child: Padding(
                     padding: const EdgeInsets.all(24.0),
                     child: Text(
                       _activeQuote!,
                       textAlign: TextAlign.center,
                       style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                     ),
                   ),
                 ),
               ),
             ),
           ),
      ],
    );
  }

  Map<String, dynamic>? _getCooldownParams() {
    if (goal.lastCompletedAt == null) return null;
    
    final now = DateTime.now();
    final difference = now.difference(goal.lastCompletedAt!);
    final cooldownDuration = const Duration(hours: 12);
    
    if (difference < cooldownDuration) {
       final remaining = cooldownDuration - difference;
       return {
         'hours': remaining.inHours,
         'minutes': remaining.inMinutes % 60,
       };
    }
    return null;
  }

  Widget _buildActionButtons(bool isTargetMet, bool isExpired, bool isCooldown, Map<String, dynamic>? cooldownParams, Color primaryColor) {
     if (isTargetMet) {
       return SizedBox(
         width: double.infinity,
         child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 16, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                "Completed with discipline",
                style: TextStyle(color: Colors.amber.shade700, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
         ),
       );
     }
     
     if (isExpired) {
       return SizedBox(
         width: double.infinity,
         child: Text(
           "Missed — reflect, then move on",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.withOpacity(0.7), fontSize: 13, fontStyle: FontStyle.italic),
         ),
       );
     }
     
     if (isCooldown) {
       final hours = cooldownParams?['hours'] ?? 0;
       final minutes = cooldownParams?['minutes'] ?? 0;
       return Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           SizedBox(
             width: double.infinity,
             height: 52,
             child: OutlinedButton.icon(
               icon: const Icon(Icons.hourglass_empty, size: 20),
               label: Text("Next session available in ${hours}h ${minutes}m"),
               onPressed: null, // Disabled
               style: OutlinedButton.styleFrom(
                 foregroundColor: Colors.grey,
                 side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
               ),
             ),
           ),
           const SizedBox(height: 8),
           Text(
             "Sessions are spaced to keep progress honest.",
             style: TextStyle(
               color: Colors.grey.shade600,
               fontSize: 12,
             ),
             textAlign: TextAlign.center,
           ),
         ],
       );
     }
     
     // Normal Active State
     return SizedBox(
       height: 52,
       width: double.infinity,
       child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(begin: primaryColor, end: primaryColor),
        duration: const Duration(milliseconds: 400),
        builder: (context, btnColor, _) {
          return ElevatedButton.icon(
            icon: const Icon(Icons.check, size: 20, color: Colors.black),
            label: Text(
              loading ? 'Updating...' : 'Complete Session',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onPressed: (loading) ? null : onComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: btnColor ?? primaryColor,
              elevation: 0,
              shadowColor: Colors.transparent, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          );
        },
      ),
    );
  }
}
