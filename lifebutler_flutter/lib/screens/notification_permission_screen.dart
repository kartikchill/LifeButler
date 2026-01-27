import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';
import '../services/notification_service.dart';

class NotificationPermissionScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const NotificationPermissionScreen({super.key, required this.onContinue});

  @override
  State<NotificationPermissionScreen> createState() => _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState extends State<NotificationPermissionScreen> {
  bool _loading = false;

  Future<void> _requestPermission() async {
    setState(() => _loading = true);
    final granted = await NotificationService().requestPermission();
    setState(() => _loading = false);
    
    // Whether granted or not, we proceed. 
    // If denied, we just won't send notifications.
    if (mounted) widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Icon(Icons.notifications_active_outlined, size: 80, color: Colors.amber),
            const SizedBox(height: 32),
            const Text(
              "Accountability,\nnot Spam.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "We won't bug you daily.\nWe'll only remind you when you're at risk of missing your commitment.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: "Enable Smart Notifications",
              isLoading: _loading,
              onPressed: _requestPermission,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: widget.onContinue,
              child: Text(
                "Maybe Later",
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
