import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/responsive.dart';
import '../core/theme_context.dart';

/// Consistent section heading: an eyebrow pill, a title and a subtitle.
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final IconData icon;
  final String? title;
  final String? subtitle;
  final bool centered;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.icon,
    this.title,
    this.subtitle,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    final align = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primary, size: 16),
              const SizedBox(width: 8),
              Text(
                eyebrow.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
        ),
        if (title != null) ...[
          const SizedBox(height: 18),
          Text(
            title!,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: context.isMobile ? 28 : 40,
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
          ),
        ],
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              subtitle!,
              textAlign: textAlign,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: context.textSecondary),
            ),
          ),
        ],
      ],
    );
  }
}
