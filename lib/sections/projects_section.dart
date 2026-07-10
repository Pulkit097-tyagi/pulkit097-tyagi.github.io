import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../models/project.dart';
import '../widgets/glass_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedFilter = 'All';

  Future<void> _launchUrl(String? url) async {
    if (url == null) return;
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredProjects = AppConstants.projects.where((project) {
      if (_selectedFilter == 'All') return true;
      if (_selectedFilter == 'Featured') return project.isFeatured;
      return project.tags.any((tag) => tag.toLowerCase() == _selectedFilter.toLowerCase());
    }).toList();

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
                'MY PORTFOLIO',
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
            'Featured Projects',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: context.isMobile ? 28 : 40,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'A selection of recent applications I have designed and engineered.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget buildFilters() {
      final filters = ['All', 'Featured', 'Flutter', 'Firebase', 'SQLite', 'REST API', 'Agri-Tech'];

      return Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return ChoiceChip(
            label: Text(
              filter,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              }
            },
            selectedColor: AppColors.primary,
            backgroundColor: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? Colors.transparent
                    : (isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder),
              ),
            ),
            showCheckmark: false,
          );
        }).toList(),
      );
    }

    Widget buildProjectCard(Project project) {
      bool show = (project.githubUrl != null || project.androidUrl != null || project.iosUrl != null) ? true : false;
      return GlassCard(
        animateOnHover: true,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overlapping Phone Mockups Header
            PhoneMockupWidget(
              projectType: project.imageUrl,
              isFeatured: project.isFeatured,
            ),
            // Project details description area
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(project.imagePath, height: project.imagePath.toString().contains("housethat") ? 30 : 25, width: 35,),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          project.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      height: 1.5,
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
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (show)
                  const SizedBox(height: 20),
                  if (show)
                  const Divider(height: 1),
                  if (show)
                  const SizedBox(height: 12),
                  // Links footer
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (project.githubUrl != null)
                        TextButton.icon(
                          onPressed: () => _launchUrl(project.githubUrl),
                          icon: FaIcon(FontAwesomeIcons.github, size: 16),
                          label: const Text('Source Code', style: TextStyle(fontSize: 13)),
                          style: TextButton.styleFrom(
                            foregroundColor: isDark ? Colors.white70 : Colors.black87,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      if (project.androidUrl != null)
                        TextButton.icon(
                          onPressed: () => _launchUrl(project.androidUrl),
                          icon: const Icon(Icons.open_in_new_rounded, size: 16),
                          label: const Text('Android', style: TextStyle(fontSize: 13)),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.secondary,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      if (project.iosUrl != null)
                        TextButton.icon(
                          onPressed: () => _launchUrl(project.iosUrl),
                          icon: const Icon(Icons.open_in_new_rounded, size: 16),
                          label: const Text('IOS', style: TextStyle(fontSize: 13)),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.secondary,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
              const SizedBox(height: 36),
              buildFilters(),
              const SizedBox(height: 48),
              filteredProjects.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        'No projects match the selected criteria.',
                        style: TextStyle(color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProjects.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.isMobile ? 1 : (context.isTablet ? 2 : 3),
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: context.isMobile ? 0.70 : (context.isTablet ? 0.60 : 0.85),
                      ),
                      itemBuilder: (context, index) {
                        return buildProjectCard(filteredProjects[index]);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneMockupWidget extends StatelessWidget {
  final String projectType;
  final bool isFeatured;

  const PhoneMockupWidget({
    super.key,
    required this.projectType,
    required this.isFeatured,
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

      if (projectType == 'wechat') {
        if (position == 1) {
          mockScreenContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 12, color: Colors.blueAccent.withOpacity(0.3)),
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
                    color: AppColors.primary.withOpacity(0.3),
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
                padding: const EdgeInsets.only(top: 8),
                child: mockScreenContent,
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
