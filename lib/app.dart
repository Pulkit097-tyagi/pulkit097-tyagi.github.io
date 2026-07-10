import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'core/colors.dart';
import 'core/responsive.dart';
import 'providers/theme_provider.dart';
import 'providers/nav_provider.dart';
import 'widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer.dart';

class AppMainShell extends ConsumerStatefulWidget {
  const AppMainShell({super.key});

  @override
  ConsumerState<AppMainShell> createState() => _AppMainShellState();
}

class _AppMainShellState extends ConsumerState<AppMainShell> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final navState = ref.watch(navProvider);
    final navNotifier = ref.read(navProvider.notifier);

    // Glowing Ambient Neon Blobs for Dark Mode Visual Appeal
    Widget buildBackgroundBlobs() {
      if (!isDark) return const SizedBox.shrink();

      final width = MediaQuery.sizeOf(context).width;
      final height = MediaQuery.sizeOf(context).height;

      return Stack(
        children: [
          // Blob 1 (Top Left - Indigo)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: width * 0.4,
              height: width * 0.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.darkBlobColor1, Colors.transparent],
                  radius: 0.7,
                ),
              ),
            ),
          ),
          // Blob 2 (Mid Right - Cyan)
          Positioned(
            top: height * 0.8,
            right: -150,
            child: Container(
              width: width * 0.45,
              height: width * 0.45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.darkBlobColor2, Colors.transparent],
                  radius: 0.7,
                ),
              ),
            ),
          ),
          // Blob 3 (Far Bottom Left - Pink)
          Positioned(
            bottom: height * 0.2,
            left: -150,
            child: Container(
              width: width * 0.4,
              height: width * 0.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.darkBlobColor3, Colors.transparent],
                  radius: 0.7,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget buildSection(int index, Widget sectionWidget) {
      return VisibilityDetector(
        key: Key('section_detector_$index'),
        onVisibilityChanged: (info) {
          // If more than 40% of the section is visible on screen, update active navbar index
          if (info.visibleFraction > 0.40) {
            navNotifier.setActiveIndex(index);
          }
        },
        child: Container(
          key: navState.keys[index],
          child: sectionWidget,
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(),
      endDrawer: context.isTabletOrMobile ? const MobileDrawer() : null,
      body: Stack(
        children: [
          // Background blobs behind list
          buildBackgroundBlobs(),
          // Main Scrollable Area
          SelectionArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Spacer to push content below modern transparent navbar
                  const SizedBox(height: 70),
                  buildSection(0, const HeroSection()),
                  buildSection(1, const AboutSection()),
                  buildSection(2, const SkillsSection()),
                  buildSection(3, const ProjectsSection()),
                  buildSection(4, const ExperienceSection()),
                  buildSection(5, const ContactSection()),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
