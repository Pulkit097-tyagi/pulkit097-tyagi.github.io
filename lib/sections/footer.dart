import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/theme_context.dart';
import '../providers/nav_provider.dart';

class Footer extends ConsumerWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final navNotifier = ref.read(navProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.02),
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Text(
                          'PT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppConstants.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  
                  // Scroll to top button
                  Tooltip(
                    message: 'Scroll to Top',
                    child: IconButton(
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () => navNotifier.scrollTo(AppSection.home),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        foregroundColor: AppColors.primary,
                        hoverColor: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(height: 1, color: context.glassBorder),
              const SizedBox(height: 24),
              // Sub text
              SizedBox(
                width: double.infinity,
                child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text(
                    '© 2026 Pulkit Tyagi. All rights reserved.',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textSecondary,
                    ),
                  ),
                  Text(
                    'Built with ❤️ using Flutter',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textSecondary,
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
