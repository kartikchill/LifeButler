import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = widget.backgroundColor ?? theme.primaryColor;
    final fgColor = widget.foregroundColor ?? Colors.black;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.onPressed == null ? theme.disabledColor : bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: widget.onPressed == null 
              ? []
              : [
                  BoxShadow(
                    color: bgColor.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, color: fgColor, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: fgColor,
                          fontSize: 16, // Use Inter 16px
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
