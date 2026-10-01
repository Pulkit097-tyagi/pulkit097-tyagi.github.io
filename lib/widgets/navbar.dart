import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme_context.dart';
import '../providers/theme_provider.dart';
import '../providers/nav_provider.dart';

class Navbar extends ConsumerWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kNavbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final isScrolled = ref.watch(navProvider.select((s) => s.isScrolled));
    final navNotifier = ref.read(navProvider.notifier);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: isScrolled ? 14.0 : 0.0, sigmaY: isScrolled ? 14.0 : 0.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: kNavbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: isScrolled
                ? (isDark ? AppColors.darkBg : AppColors.lightBg).withValues(alpha: 0.75)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isScrolled ? context.glassBorder : Colors.transparent,
                width: 1.0,
              ),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                children: [
                  // Logo takes all free space (so links sit flush right) and
                  // ellipsizes only when the screen is genuinely too narrow.
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _Logo(onTap: () => navNotifier.scrollTo(AppSection.home)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (Responsive.isDesktop(context)) ...[
                    for (final section in AppSection.values)
                      _NavbarLink(
                        section: section,
                        onTap: () => navNotifier.scrollTo(section),
                      ),
                    const SizedBox(width: 12),
                    const _ThemeToggle(),
                  ] else ...[
                    const _ThemeToggle(),
                    const SizedBox(width: 4),
                    IconButton(
                      tooltip: 'Menu',
                      icon: Icon(Icons.menu_rounded, color: context.textPrimary),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'PT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
              AppConstants.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2,
                color: context.textPrimary,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeToggle extends ConsumerWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;

    return IconButton(
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => RotationTransition(
          turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
          color: context.textPrimary,
        ),
      ),
    );
  }
}

class _NavbarLink extends ConsumerStatefulWidget {
  final AppSection section;
  final VoidCallback onTap;

  const _NavbarLink({
    required this.section,
    required this.onTap,
  });

  @override
  ConsumerState<_NavbarLink> createState() => _NavbarLinkState();
}

class _NavbarLinkState extends ConsumerState<_NavbarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Each link rebuilds only when its own active flag flips.
    final isActive = ref.watch(navProvider.select((s) => s.active == widget.section));
    final color = isActive
        ? AppColors.primary
        : (_isHovered ? context.textPrimary : context.textSecondary);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: color,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 15,
                ),
                child: Text(widget.section.label),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                height: 2,
                width: isActive ? 20 : (_isHovered ? 10 : 0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileDrawer extends ConsumerWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final active = ref.watch(navProvider.select((s) => s.active));
    final navNotifier = ref.read(navProvider.notifier);

    return Drawer(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Navigation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.textPrimary,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    icon: Icon(Icons.close_rounded, color: context.textPrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: context.glassBorder),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                children: [
                  for (final section in AppSection.values)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        selected: active == section,
                        selectedTileColor: AppColors.primary.withValues(alpha: 0.1),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                        title: Text(
                          section.label,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: active == section ? FontWeight.bold : FontWeight.w500,
                            color: active == section ? AppColors.primary : context.textSecondary,
                          ),
                        ),
                        trailing: active == section
                            ? const Icon(Icons.chevron_right_rounded, color: AppColors.primary)
                            : null,
                        onTap: () {
                          Navigator.of(context).pop(); // Close drawer
                          navNotifier.scrollTo(section);
                        },
                      ),
                    ),
                ],
              ),
            ),
            Divider(height: 1, color: context.glassBorder),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                '© 2026 Pulkit Tyagi',
                style: TextStyle(color: context.textSecondary, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
