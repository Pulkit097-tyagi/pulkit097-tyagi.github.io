import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/theme_context.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildHeader() {
      return const SectionHeader(
        eyebrow: 'My Skills',
        icon: Icons.verified_outlined,
        title: 'Technologies & Expertise',
        subtitle: 'Here are the core programming languages, frameworks, and databases I work with.',
      );
    }

    Widget buildSkillsWrap() {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: AppConstants.skills.map((skill) {
          return GlassCard(
            width: 120,
            height: 124,
            animateOnHover: true,
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (skill.iconData != null)
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.14),
                          AppColors.secondary.withValues(alpha: 0.10),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: skill.iconData is FaIconData
                          ? FaIcon(
                              skill.iconData,
                              color: AppColors.primary,
                              size: 22,
                            )
                          : Icon(
                              skill.iconData as IconData?,
                              color: AppColors.primary,
                              size: 22,
                            ),
                    ),
                  ),
                const SizedBox(height: 10),
                Text(
                  skill.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              buildHeader(),
              const SizedBox(height: 48),
              buildSkillsWrap(),
            ],
          ),
        ),
      ),
    );
  }
}
