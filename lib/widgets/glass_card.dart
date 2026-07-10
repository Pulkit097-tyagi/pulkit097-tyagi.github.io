import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/colors.dart';
import '../providers/theme_provider.dart';

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
    return Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeProvider);
        final isDark = themeMode == ThemeMode.dark;

        final glassBg = isDark ? AppColors.darkGlassBg : AppColors.lightGlassBg;
        final glassBorder = isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder;
        final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;

        Widget cardContent = ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: widget.padding,
              decoration: BoxDecoration(
                color: _isHovered && widget.animateOnHover
                    ? cardColor.withOpacity(isDark ? 0.35 : 0.95)
                    : glassBg.withOpacity(isDark ? 0.12 : 0.08),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: _isHovered && widget.animateOnHover
                      ? AppColors.primary.withOpacity(0.5)
                      : glassBorder,
                  width: 1.5,
                ),
                boxShadow: _isHovered && widget.animateOnHover
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(isDark ? 0.25 : 0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : [],
              ),
              child: widget.child,
            ),
          ),
        );

        if (widget.onTap != null) {
          cardContent = GestureDetector(
            onTap: widget.onTap,
            child: cardContent,
          );
        }

        if (widget.animateOnHover) {
          cardContent = MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              transform: Matrix4.identity()
                ..translate(0.0, _isHovered ? -6.0 : 0.0, 0.0)
                ..scale(_isHovered ? 1.02 : 1.0),
              child: cardContent,
            ),
          );
        }

        return cardContent;
      },
    );
  }
}
