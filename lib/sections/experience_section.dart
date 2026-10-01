import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme_context.dart';
import '../models/experience.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const double _nodeColumnWidth = 60;
  static const double _nodeTop = 24;
  static const double _nodeCenter = _nodeTop + 22; // node is 44px tall

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    Widget buildHeader() {
      return const SectionHeader(
        eyebrow: 'My Journey',
        icon: Icons.timeline_rounded,
        title: 'Work & Education',
        subtitle: 'A retrospective of my professional positions and academic training.',
      );
    }

    Widget periodChip(String period) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          period,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    Widget buildTimelineItem(Experience exp, int index, int total) {
      final isWork = exp.type == ExperienceType.work;
      final nodeIcon = isWork ? Icons.work_outline_rounded : Icons.school_outlined;
      final nodeColor = isWork ? AppColors.primary : AppColors.secondary;

      // Node circle; its centre sits [_nodeCenter] px below the row top.
      Widget timelineNode() {
        return Padding(
          padding: const EdgeInsets.only(top: _nodeTop),
          child: Center(
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: nodeColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: nodeColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Icon(nodeIcon, color: nodeColor, size: 20),
            ),
          ),
        );
      }

      // Connecting line drawn behind the row, so the row's height comes from
      // the card alone (no IntrinsicHeight, which mis-measures text on web).
      List<Widget> timelineLines(double centerX) {
        final lineColor = AppColors.primary.withValues(alpha: 0.2);
        return [
          if (index != 0)
            Positioned(
              left: centerX - 1,
              top: 0,
              height: _nodeCenter,
              child: Container(width: 2, color: lineColor),
            ),
          if (index != total - 1)
            Positioned(
              left: centerX - 1,
              top: _nodeCenter,
              bottom: 0,
              child: Container(width: 2, color: lineColor),
            ),
        ];
      }

      Widget detailsCard() {
        return GlassCard(
          animateOnHover: true,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.isMobile) ...[
                periodChip(exp.period),
                const SizedBox(height: 10),
              ],
              Text(
                exp.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimary,
                ),
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
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 14, color: context.textSecondary),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      exp.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              if (exp.bulletPoints != null && exp.bulletPoints!.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...exp.bulletPoints!.map((bullet) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
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
                                fontSize: 13,
                                height: 1.5,
                                color: context.textSecondary,
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
        return Stack(
          children: [
            ...timelineLines(_nodeColumnWidth / 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: _nodeColumnWidth, child: timelineNode()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
                    child: detailsCard(),
                  ),
                ),
              ],
            ),
          ],
        );
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          // Period column takes 2/7 of the space left beside the node column.
          final periodWidth = (constraints.maxWidth - _nodeColumnWidth) * 2 / 7;
          return Stack(
            children: [
              ...timelineLines(periodWidth + _nodeColumnWidth / 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Period (Left), vertically aligned with the node
                  SizedBox(
                    width: periodWidth,
                    height: _nodeCenter * 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: periodChip(exp.period),
                      ),
                    ),
                  ),
                  // Center Node
                  SizedBox(width: _nodeColumnWidth, child: timelineNode()),
                  // Card Details (Right)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32.0, left: 32.0),
                      child: detailsCard(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
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
