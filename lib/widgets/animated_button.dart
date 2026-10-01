import 'package:flutter/material.dart';
import '../core/colors.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final IconData? icon;
  final double? width;
  final double height;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.icon,
    this.width,
    this.height = 50,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primary;
    final hoverColor = AppColors.secondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: widget.width,
          height: widget.height,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..scaleByDouble(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0, 1.0, 1.0),
          decoration: widget.isSecondary
              ? BoxDecoration(
                  color: _isHovered ? primaryColor.withValues(alpha: 0.08) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered ? hoverColor : primaryColor,
                    width: 2.0,
                  ),
                )
              : BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovered
                        ? [hoverColor, primaryColor]
                        : [primaryColor, hoverColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: _isHovered ? 0.45 : 0.25),
                      blurRadius: _isHovered ? 20 : 12,
                      offset: Offset(0, _isHovered ? 8 : 4),
                    ),
                  ],
                ),
          // Only centre inside an explicit width; otherwise size to the label.
          alignment: widget.width != null ? Alignment.center : null,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: widget.isSecondary
                      ? (_isHovered ? hoverColor : primaryColor)
                      : Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: widget.isSecondary
                        ? (_isHovered ? hoverColor : primaryColor)
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
