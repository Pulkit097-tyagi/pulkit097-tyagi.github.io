import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/theme_context.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool animateOnHover;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(24.0),
    this.animateOnHover = true,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final highlighted = _isHovered && widget.animateOnHover;

    final baseColor = isDark
        ? Colors.white.withValues(alpha: 0.035)
        : Colors.white.withValues(alpha: 0.85);
    final hoverColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.white;

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      clipBehavior: Clip.antiAlias,
      transformAlignment: Alignment.center,
      transform: Matrix4.translationValues(0.0, highlighted ? -4.0 : 0.0, 0.0),
      decoration: BoxDecoration(
        color: highlighted ? hoverColor : baseColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: highlighted
              ? AppColors.primary.withValues(alpha: 0.45)
              : context.glassBorder,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: highlighted
                ? AppColors.primary.withValues(alpha: isDark ? 0.22 : 0.14)
                : Colors.black.withValues(alpha: isDark ? 0.0 : 0.04),
            blurRadius: highlighted ? 28 : 12,
            offset: Offset(0, highlighted ? 12 : 4),
          ),
        ],
      ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      card = GestureDetector(onTap: widget.onTap, child: card);
    }

    if (widget.animateOnHover || widget.onTap != null) {
      card = MouseRegion(
        cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: card,
      );
    }

    return card;
  }
}
