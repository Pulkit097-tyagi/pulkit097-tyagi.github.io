import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/colors.dart';
import 'core/responsive.dart';
import 'core/theme_context.dart';
import 'providers/nav_provider.dart';
import 'widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer.dart';

class AppMainShell extends ConsumerWidget {
  const AppMainShell({super.key});

  static const Map<AppSection, Widget> _sections = {
    AppSection.home: HeroSection(),
    AppSection.about: AboutSection(),
    AppSection.skills: SkillsSection(),
    AppSection.projects: ProjectsSection(),
    AppSection.experience: ExperienceSection(),
    AppSection.contact: ContactSection(),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only static dependencies are read here, so scrolling and nav changes
    // never rebuild the page content.
    final controller = ref.watch(scrollControllerProvider);
    final keys = ref.watch(sectionKeysProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(),
      endDrawer: context.isTabletOrMobile ? const MobileDrawer() : null,
      floatingActionButton: const _BackToTopButton(),
      body: Stack(
        children: [
          const Positioned.fill(child: _BackgroundBlobs()),
          SelectionArea(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  // Spacer to push content below the floating navbar
                  const SizedBox(height: kNavbarHeight),
                  for (final entry in _sections.entries)
                    KeyedSubtree(key: keys[entry.key], child: entry.value),
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

/// Soft ambient glows behind the content, tuned per theme.
class _BackgroundBlobs extends StatelessWidget {
  const _BackgroundBlobs();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final width = context.screenWidth;
    final height = context.screenHeight;

    Widget blob(Color color, double size) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent], radius: 0.7),
        ),
      );
    }

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: blob(isDark ? AppColors.darkBlobColor1 : AppColors.lightBlobColor1, width * 0.4),
          ),
          Positioned(
            top: height * 0.8,
            right: -150,
            child: blob(isDark ? AppColors.darkBlobColor2 : AppColors.lightBlobColor2, width * 0.45),
          ),
          Positioned(
            bottom: height * 0.2,
            left: -150,
            child: blob(isDark ? AppColors.darkBlobColor3 : AppColors.lightBlobColor3, width * 0.4),
          ),
        ],
      ),
    );
  }
}

class _BackToTopButton extends ConsumerWidget {
  const _BackToTopButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(navProvider.select((s) => s.showBackToTop));

    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, 2),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        child: IgnorePointer(
          ignoring: !visible,
          child: Tooltip(
            message: 'Scroll to Top',
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: IconButton(
                iconSize: 26,
                color: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_up_rounded),
                onPressed: () => ref.read(navProvider.notifier).scrollTo(AppSection.home),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
