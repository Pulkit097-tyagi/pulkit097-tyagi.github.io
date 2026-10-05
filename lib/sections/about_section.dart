import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme_context.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isStatsVisible = false;

  Future<void> _downloadCV() async {
    final Uri uri = Uri.parse(AppConstants.cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBio() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'About Me',
            icon: Icons.person_outline_rounded,
            centered: false,
          ),
          const SizedBox(height: 24),
          Text(
            AppConstants.detailedBio,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.textSecondary,
                ),
          ),
          const SizedBox(height: 24),
          
          // Bullet points matching mockup with chevrons
          Column(
            children: AppConstants.aboutBullets.map((bullet) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: AppColors.primary,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        bullet,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 36),
          
          // More About Me CTA
          AnimatedButton(
            text: 'More About Me',
            icon: Icons.arrow_forward_rounded,
            onPressed: _downloadCV,
            width: 200,
          ),
        ],
      );
    }

    Widget buildStatsGrid() {
      return VisibilityDetector(
        key: const Key('about-stats-detector'),
        onVisibilityChanged: (info) {
          // Start counting as soon as the grid enters the viewport.
          if (info.visibleFraction > 0.05 && !_isStatsVisible) {
            setState(() {
              _isStatsVisible = true;
            });
          }
        },
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppConstants.stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.isMobile ? 1 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: context.isMobile ? 3.0 : 1.7,
          ),
          itemBuilder: (context, index) {
            final stat = AppConstants.stats[index];
            final int targetValue = stat['value'] as int;
            final IconData statIcon = stat['icon'] as IconData;

            return GlassCard(
              animateOnHover: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  // Icon box matching mockup
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        width: 1.0,
                      ),
                    ),
                    child: Icon(
                      statIcon,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Text elements column matching mockup
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeOutCubic,
                          tween: Tween<double>(
                            begin: 0.0,
                            end: _isStatsVisible ? targetValue.toDouble() : 0.0,
                          ),
                          builder: (context, value, child) {
                            // round(), not toInt(): flooring an ease-out curve
                            // holds "target - 1" until the very last frame, so
                            // small targets (2, 3, 8) looked stuck.
                            return Text(
                              '${value.round()}${stat['suffix']}',
                              style: TextStyle(
                                fontSize: context.isMobile ? 22 : 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                // Fixed-width digits so the card doesn't jitter while counting
                                fontFeatures: const [FontFeature.tabularFigures()],
                                color: context.textPrimary,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stat['label'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Responsive(
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildBio(),
                const SizedBox(height: 48),
                buildStatsGrid(),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: buildBio()),
                const SizedBox(width: 64),
                Expanded(flex: 3, child: buildStatsGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
