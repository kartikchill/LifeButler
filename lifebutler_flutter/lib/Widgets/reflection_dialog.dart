import 'package:flutter/material.dart';
import 'package:lifebutler_client/lifebutler_client.dart';
import '../services/api_service.dart';

class ReflectionDialog extends StatefulWidget {
  final Goal goal;
  final bool isCompleted;

  const ReflectionDialog({
    super.key, 
    required this.goal,
    required this.isCompleted,
  });

  @override
  State<ReflectionDialog> createState() => _ReflectionDialogState();
}

class _ReflectionDialogState extends State<ReflectionDialog> {
  final _controller = TextEditingController();
  bool _loading = false;

  String get _prompt {
    if (widget.isCompleted) {
      return "What worked well? What would you change next time?";
    } else {
      return "What made it hard? What would you adjust?";
    }
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      Navigator.pop(context); // Treat empty as skip/close
      return;
    }

    setState(() => _loading = true);

    final reflection = Reflection(
      userId: ApiService.demoUserId,
      goalId: widget.goal.id,
      type: widget.isCompleted ? 0 : 1, // 0=Completed, 1=Missed
      content: text,
      createdAt: DateTime.now(),
    );

    try {
      await ApiService.addReflection(reflection);
      if (mounted) Navigator.pop(context, true); // True = saved
    } catch (e) {
      if (mounted) {
         setState(() => _loading = false);
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AlertDialog(
      backgroundColor: theme.cardColor,
      title: Text(widget.isCompleted ? 'Goal Completed!' : 'Goal Reflection'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _prompt, 
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.surface.withValues(alpha: 0.3),
                hintText: 'Type your reflection here...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: const Text('Skip'),
        ),
        ElevatedButton(
          onPressed: _loading ? null : _submit,
          child: _loading 
             ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) 
             : const Text('Save Reflection'),
        ),
      ],
    );
  }
}
