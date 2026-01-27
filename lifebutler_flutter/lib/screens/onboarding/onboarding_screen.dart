import 'package:flutter/material.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import '../../services/preferences_service.dart';
import '../../services/notification_service.dart';
import '../../widgets/primary_button.dart';
import '../add_goal_screen.dart';
import '../dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finishOnboarding() async {
    await PreferencesService().setHasSeenOnboarding(true);
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (route) => false
    );
    
    final defaultGoal = Goal(
       id: 0, // dummy
       userId: 0, 
       title: '', 
       targetCount: 3, 
       periodType: 'week', 
       consistencyStyle: 'dailyAnchor', 
       anchorTime: DateTime.now().copyWith(hour: 20, minute: 0),
       createdAt: DateTime.now(),
       completedCount: 0,
       periodStart: DateTime.now(),
       periodEnd: DateTime.now().add(const Duration(days: 7)),
       isActive: true 
    );

    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AddGoalScreen(templateGoal: defaultGoal))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finishOnboarding,
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                   // Screen 1: Welcome
                  _buildContentPage(
                    title: "Welcome to LifeButler",
                    subtitle: "Make today count.",
                    content: const Text(
                      "LifeButler helps you build habits without pressure.\n\nYou decide the pace — we help you stay consistent.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    icon: Icons.check_circle_outline,
                    ctaLabel: "Next →",
                    onCta: _nextPage,
                  ),
                  
                  // Screen 2: Commitments
                  _buildContentPage(
                    title: "Commitments, Your Way",
                    content: Column(
                      children: [
                         _buildInfoCard(
                           icon: Icons.edit_note, 
                           title: "Create a commitment",
                           desc: "Gym, study, work, anything."
                         ),
                         const SizedBox(height: 12),
                         _buildInfoCard(
                           icon: Icons.repeat, 
                           title: "Choose sessions",
                           desc: "Set how many times per week/month."
                         ),
                         const SizedBox(height: 12),
                         _buildInfoCard(
                           icon: Icons.timer_off_outlined, 
                           title: "Finish anytime",
                           desc: "Complete them before the deadline."
                         ),
                      ],
                    ),
                    helper: "No fixed daily rules. Progress when it fits your life.",
                    ctaLabel: "Next →",
                    onCta: _nextPage,
                  ),

                  // Screen 3: Reminders
                  _buildContentPage(
                    title: "Smart Reminders",
                    content: Column(
                      children: [
                        _buildFeatureCard(
                          title: "Daily Anchor",
                          desc: "Get reminded at the same time every day.",
                          icon: Icons.anchor,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureCard(
                          title: "Flexible",
                          desc: "We remind you more when deadlines get closer.",
                          icon: Icons.notifications_active,
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                    helper: "You choose this for every commitment.",
                    ctaLabel: "Next →",
                    onCta: _nextPage,
                  ),

                  // Screen 4: Progress
                   _buildContentPage(
                    title: "See Your Progress",
                    content: Column(
                      children: [
                         _buildInfoCard(
                           icon: Icons.calendar_view_week,
                           title: "Weekly Reviews",
                           desc: "See what you've completed this week.",
                         ),
                         const SizedBox(height: 12),
                         _buildInfoCard(
                           icon: Icons.calendar_month,
                           title: "Monthly Reviews",
                           desc: "Track your long-term consistency.",
                         ),
                         const SizedBox(height: 12),
                         _buildInfoCard(
                           icon: Icons.favorite_border,
                           title: "No Guilt",
                           desc: "Just clarity on where you stand.",
                         ),
                      ],
                    ),
                    helper: "Consistency beats perfection.",
                    ctaLabel: "Enable Reminders →",
                    onCta: _nextPage,
                  ),

                   // Screen 5: Notifications
                   _NotificationPermissionPage(
                     onContinue: _finishOnboarding,
                   ),
                ],
              ),
            ),
            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index
                        ? Colors.amber
                        : Colors.white.withValues(alpha: 0.2),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoCard({required IconData icon, required String title, required String desc}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14)),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildFeatureCard({required String title, required String desc, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
           Container(
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
               color: color.withValues(alpha: 0.2),
               shape: BoxShape.circle,
             ),
             child: Icon(icon, color: color, size: 32),
           ),
           const SizedBox(width: 20),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                 const SizedBox(height: 6),
                 Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14, height: 1.4)),
               ],
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildContentPage({
    required String title,
    String? subtitle,
    required Widget content,
    String? helper,
    IconData? icon,
    required String ctaLabel,
    required VoidCallback onCta,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          if (icon != null) ...[
             Icon(icon, size: 64, color: Colors.amber),
             const SizedBox(height: 24),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 12),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.6),
                letterSpacing: 0.5,
              ),
            ),
          ],
          const Spacer(), // Pushed content to middle/bottom
          content,
          const Spacer(),
          if (helper != null) ...[
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
               margin: const EdgeInsets.only(bottom: 24),
               decoration: BoxDecoration(
                 color: Colors.amber.withValues(alpha: 0.1),
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
               ),
               child: Text(
                 helper,
                 textAlign: TextAlign.center,
                 style: const TextStyle(
                   fontSize: 14,
                   fontWeight: FontWeight.w500,
                   color: Colors.amber,
                 ),
               ),
             ),
          ],
          PrimaryButton(
            label: ctaLabel,
            onPressed: onCta,
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _NotificationPermissionPage extends StatefulWidget {
  final VoidCallback onContinue;

  const _NotificationPermissionPage({required this.onContinue});

  @override
  State<_NotificationPermissionPage> createState() => _NotificationPermissionPageState();
}

class _NotificationPermissionPageState extends State<_NotificationPermissionPage> {
  bool _loading = false;

  Future<void> _requestPermission() async {
    setState(() => _loading = true);
    await NotificationService().requestPermission();
    setState(() => _loading = false);
    widget.onContinue();
  }

  Future<void> _skip() async {
    await PreferencesService().setNotificationPermissionAsked(true);
    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
             padding: const EdgeInsets.all(24),
             decoration: BoxDecoration(
               color: Colors.amber.withValues(alpha: 0.1),
               shape: BoxShape.circle,
             ),
             child: const Icon(Icons.notifications_active_outlined, size: 64, color: Colors.amber),
          ),
          const SizedBox(height: 32),
          const Text(
            "Allow Notifications",
            textAlign: TextAlign.center,
             style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          _buildBullet("Remind you about commitments"),
          _buildBullet("Alert you when deadlines approach"),
          _buildBullet("Celebrate when you complete goals"),
          const Spacer(),
          PrimaryButton(
            label: "Allow Notifications",
            isLoading: _loading,
            onPressed: _requestPermission,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _skip,
            child: Text(
              "Skip for now",
               style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 16),
       child: Row(
         children: [
           const Icon(Icons.check, color: Colors.greenAccent, size: 20),
           const SizedBox(width: 12),
           Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
         ],
       ),
     );
  }
}
