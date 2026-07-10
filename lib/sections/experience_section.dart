import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../models/experience.dart';
import '../widgets/glass_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'MY JOURNEY',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Work & Education',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: context.isMobile ? 28 : 40,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'A retrospective of my professional positions and academic training.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget buildTimelineItem(Experience exp, int index, int total) {
      final isWork = exp.type == ExperienceType.work;
      final nodeIcon = isWork ? Icons.work_outline_rounded : Icons.school_outlined;
      final nodeColor = isWork ? AppColors.primary : AppColors.secondary;

      Widget timelineNode() {
        return Column(
          children: [
            // Top connecting line
            Container(
              width: 2,
              height: 24,
              color: index == 0 ? Colors.transparent : AppColors.primary.withOpacity(0.2),
            ),
            // Glowing circular node
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: nodeColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: nodeColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Icon(nodeIcon, color: nodeColor, size: 20),
            ),
            // Bottom connecting line
            Expanded(
              child: Container(
                width: 2,
                color: index == total - 1 ? Colors.transparent : AppColors.primary.withOpacity(0.2),
              ),
            ),
          ],
        );
      }

      Widget detailsCard() {
        return GlassCard(
          animateOnHover: true,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    exp.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  if (context.isMobile)
                    Text(
                      exp.period,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                exp.organization,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                exp.description,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  height: 1.5,
                ),
              ),
              if (exp.bulletPoints != null && exp.bulletPoints!.isNotEmpty) ...[
                const SizedBox(height: 8),
                ...exp.bulletPoints!.map((bullet) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              bullet,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ],
          ),
        );
      }

      if (context.isMobile) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                child: timelineNode(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
                  child: detailsCard(),
                ),
              ),
            ],
          ),
        );
      } else {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Period (Left)
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 32.0, top: 12.0),
                  child: Text(
                    exp.period,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              // Center Node
              SizedBox(
                width: 60,
                child: timelineNode(),
              ),
              // Card Details (Right)
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0, left: 32.0),
                  child: detailsCard(),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              buildHeader(),
              const SizedBox(height: 64),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppConstants.experiences.length,
                itemBuilder: (context, index) {
                  return buildTimelineItem(
                    AppConstants.experiences[index],
                    index,
                    AppConstants.experiences.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
