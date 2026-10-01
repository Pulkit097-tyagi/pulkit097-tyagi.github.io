import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import '../core/responsive.dart';
import '../core/theme_context.dart';
import '../models/project.dart';
import '../providers/projects_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: const Column(
            children: [
              SectionHeader(
                eyebrow: 'My Portfolio',
                icon: Icons.folder_open_rounded,
                title: 'Featured Projects',
                subtitle: 'A selection of recent applications I have designed and engineered.',
              ),
              SizedBox(height: 36),
              _ProjectFilters(),
              SizedBox(height: 48),
              _ProjectGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectFilters extends ConsumerWidget {
  const _ProjectFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(projectFilterProvider);
    final isDark = context.isDark;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: projectFilters.map((filter) {
        final isSelected = selected == filter;
        return ChoiceChip(
          label: Text(
            filter,
            style: TextStyle(
              color: isSelected ? Colors.white : context.textSecondary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => ref.read(projectFilterProvider.notifier).select(filter),
          selectedColor: AppColors.primary,
          backgroundColor: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? Colors.transparent : context.glassBorder,
            ),
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}

class _ProjectGrid extends ConsumerWidget {
  const _ProjectGrid();

  static const double _spacing = 24;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(filteredProjectsProvider);

    if (projects.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Text(
          'No projects match the selected criteria.',
          style: TextStyle(color: context.textSecondary),
        ),
      );
    }

    final columns = context.isMobile ? 1 : (context.isTablet ? 2 : 3);

    // Rows of top-aligned cards whose height follows their own content, so
    // nothing is clipped at any width. IntrinsicHeight is deliberately
    // avoided: it under-measures wrapped text on web and caused overflows.
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Column(
        key: ValueKey(projects),
        children: [
          for (var start = 0; start < projects.length; start += columns)
            Padding(
              padding: EdgeInsets.only(top: start == 0 ? 0 : _spacing),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = start; i < start + columns; i++) ...[
                    if (i != start) const SizedBox(width: _spacing),
                    Expanded(
                      child: i < projects.length
                          ? _ProjectCard(project: projects[i])
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({required this.project});

  Future<void> _launchUrl(String? url) async {
    if (url == null) return;
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final hasLinks = project.githubUrl != null || project.androidUrl != null || project.iosUrl != null;

    return GlassCard(
      animateOnHover: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overlapping Phone Mockups Header
          PhoneMockupWidget(
            projectType: project.imageUrl,
            isFeatured: project.isFeatured,
            images: project.appScreenshot,
          ),
          // Project details description area
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      project.imagePath,
                      height: project.imagePath.contains("housethat") ? 30 : 25,
                      width: 35,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        project.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: context.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textSecondary,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 16),
                // Tags Row
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (hasLinks) ...[
                  const SizedBox(height: 20),
                  Divider(height: 1, color: context.glassBorder),
                  const SizedBox(height: 12),
                  // Links footer
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (project.githubUrl != null)
                        _ProjectLink(
                          icon: const FaIcon(FontAwesomeIcons.github, size: 15),
                          label: 'Source Code',
                          color: isDark ? Colors.white70 : Colors.black87,
                          onPressed: () => _launchUrl(project.githubUrl),
                        ),
                      if (project.androidUrl != null)
                        _ProjectLink(
                          icon: const FaIcon(FontAwesomeIcons.googlePlay, size: 14),
                          label: 'Android',
                          color: AppColors.secondary,
                          onPressed: () => _launchUrl(project.androidUrl),
                        ),
                      if (project.iosUrl != null)
                        _ProjectLink(
                          icon: const FaIcon(FontAwesomeIcons.appStoreIos, size: 15),
                          label: 'iOS',
                          color: AppColors.secondary,
                          onPressed: () => _launchUrl(project.iosUrl),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectLink extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ProjectLink({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      style: TextButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color.withValues(alpha: 0.08),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class PhoneMockupWidget extends StatelessWidget {
  final String projectType;
  final bool isFeatured;
  final List<String>? images;

  const PhoneMockupWidget({
    super.key,
    required this.projectType,
    required this.isFeatured,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    // Gradient backgrounds for the mockup area
    final boxGradient = LinearGradient(
      colors: projectType == 'wechat'
          ? [const Color(0xFF0F172A), const Color(0xFF1E293B)]
          : projectType == 'housethat'
              ? [const Color(0xFF022C22), const Color(0xFF064E3B)]
              : projectType == 'shunyacore'
                  ? [const Color(0xFF172554), const Color(0xFF1E3A8A)]
                  : [const Color(0xFF581C87), const Color(0xFF4C1D95)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    Widget buildPhoneUI(int position) {
      Widget mockScreenContent = const SizedBox.shrink();
      bool hasImage = images != null && images!.length > position;

      if (hasImage) {
        mockScreenContent = Image.asset(
          images![position],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      } else {
        if (projectType == 'wechat') {
          if (position == 1) {
            mockScreenContent = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 12, color: Colors.blueAccent.withValues(alpha: 0.3)),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 35,
                    height: 10,
                    margin: const EdgeInsets.only(right: 4, bottom: 4),
                    decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                Container(
                  width: 40,
                  height: 10,
                  margin: const EdgeInsets.only(left: 4, bottom: 4),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 25,
                    height: 10,
                    margin: const EdgeInsets.only(right: 4, bottom: 4),
                    decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ],
            );
          } else {
            mockScreenContent = Column(
              children: List.generate(4, (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24)),
                    const SizedBox(width: 4),
                    Container(width: 20, height: 6, decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(2))),
                  ],
                ),
              )),
            );
          }
        } else if (projectType == 'housethat') {
          if (position == 1) {
            mockScreenContent = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(child: Icon(Icons.home_outlined, size: 14, color: Colors.tealAccent)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Container(width: 35, height: 6, color: Colors.white30),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Container(width: 25, height: 5, color: Colors.white12),
                ),
              ],
            );
          } else {
            mockScreenContent = Column(
              children: List.generate(2, (index) => Container(
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(4)),
              )),
            );
          }
        } else if (projectType == 'shunyacore') {
          if (position == 1) {
            mockScreenContent = Column(
              children: [
                const SizedBox(height: 4),
                Container(width: 14, height: 14, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent)),
                const SizedBox(height: 6),
                Container(width: 40, height: 6, color: Colors.white30),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 12, height: 10, color: Colors.white12),
                    const SizedBox(width: 4),
                    Container(width: 12, height: 10, color: Colors.white12),
                  ],
                )
              ],
            );
          } else {
            mockScreenContent = Column(
              children: List.generate(3, (index) => Container(
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: Colors.white12,
              )),
            );
          }
        } else {
          if (position == 1) {
            mockScreenContent = Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                    child: const Center(child: Icon(Icons.person_outline, size: 24, color: Colors.white38)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent)),
                    const SizedBox(width: 4),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent)),
                  ],
                ),
                const SizedBox(height: 2),
              ],
            );
          } else {
            mockScreenContent = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 16, height: 16, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24)),
                  const SizedBox(height: 8),
                  Container(width: 30, height: 6, color: Colors.white12),
                  const SizedBox(height: 4),
                  Container(width: 25, height: 6, color: Colors.white10),
                ],
              ),
            );
          }
        }
      }

      return Container(
        width: 76,
        height: 135,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: position == 1 ? AppColors.primary : Colors.white24,
            width: 1.5,
          ),
          boxShadow: position == 1
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 2,
              left: 4,
              right: 4,
              bottom: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: hasImage
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(top: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: mockScreenContent,
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 26,
              right: 26,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: boxGradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 220,
          height: 145,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 10,
                child: Transform.translate(
                  offset: const Offset(0, 8),
                  child: Transform.scale(
                    scale: 0.85,
                    child: buildPhoneUI(0),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: Transform.translate(
                  offset: const Offset(0, 8),
                  child: Transform.scale(
                    scale: 0.85,
                    child: buildPhoneUI(2),
                  ),
                ),
              ),
              Positioned(
                child: buildPhoneUI(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
