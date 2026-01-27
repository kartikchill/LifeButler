import 'dart:math' as math;
import 'package:flutter/material.dart';

class HeroProgressCard extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final int completedSessions;

  const HeroProgressCard({
    super.key,
    required this.progress,
    required this.completedSessions,
  });

  @override
  State<HeroProgressCard> createState() => _HeroProgressCardState();
}

class _HeroProgressCardState extends State<HeroProgressCard> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.05, end: 0.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Safe progress clamping
    final safeProgress = widget.progress.clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor,
            Color.lerp(theme.primaryColor, Colors.white, 0.15) ?? theme.primaryColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Animated Arc/Shape
          Positioned(
            right: -60,
            bottom: -60,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _pulseAnimation.value,
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: Icon(
                      Icons.pie_chart_outline_rounded,
                      size: 300,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'TOTAL PROGRESS',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Animated Percentage & Arc
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // We can add a custom paint arc here if needed, 
                    // but let's stick to the text animation as the hero.
                    
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOutCubic,
                      tween: Tween<double>(begin: 0, end: safeProgress),
                      builder: (context, value, child) {
                        final percentage = (value * 100).toInt();
                        return Text(
                          '$percentage%',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 84,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            height: 1.0,
                            letterSpacing: -2.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Secondary Stats
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, size: 20, color: Colors.black87),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.completedSessions} sessions completed',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
