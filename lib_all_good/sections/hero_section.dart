import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../widgets/animated_button.dart';
import '../widgets/social_button.dart';
import '../providers/nav_provider.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navNotifier = ref.read(navProvider.notifier);

    // Build the text description and action buttons
    Widget buildIntroText() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hi, I\'m',
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: context.isMobile ? 18 : 24,
              letterSpacing: 1,
            ),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
          const SizedBox(height: 8),
          
          // Customized name: "Pulkit" in white, "Tyagi" in blue/indigo gradient
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Pulkit ',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: context.isMobile ? 40 : 64,
                      height: 1.1,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => AppColors.textGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: Text(
                  'Tyagi',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: context.isMobile ? 40 : 64,
                        height: 1.1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 12),

          // Stationary high-profile subtitle: "Flutter Developer" in Teal/Emerald
          Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: context.isMobile ? 22 : 32,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
              letterSpacing: 0.5,
            ),
          ).animate().fadeIn(delay: 350.ms, duration: 600.ms),
          const SizedBox(height: 24),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Text(
              AppConstants.bio,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: context.isMobile ? 15 : 17,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
            ),
          ).animate().fadeIn(delay: 450.ms, duration: 600.ms),
          const SizedBox(height: 36),

          // Action Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              AnimatedButton(
                text: 'Hire Me',
                icon: Icons.send_rounded,
                onPressed: () => navNotifier.scrollToSection(5), // Contact section
              ),
              AnimatedButton(
                text: 'View Projects',
                isSecondary: true,
                icon: Icons.keyboard_arrow_down_rounded,
                onPressed: () => navNotifier.scrollToSection(3), // Projects section
              ),
            ],
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
          const SizedBox(height: 48),

          // Social Links matching mockup icons row
          Row(
            children: [
              SocialButton(
                icon: FontAwesomeIcons.github,
                url: AppConstants.githubUrl,
                tooltip: 'GitHub',
              ),
              const SizedBox(width: 16),
              SocialButton(
                icon: FontAwesomeIcons.linkedinIn,
                url: AppConstants.linkedinUrl,
                tooltip: 'LinkedIn',
              ),
              const SizedBox(width: 16),
              SocialButton(
                icon: Icons.email_outlined,
                url: 'mailto:${AppConstants.email}',
                tooltip: 'Email',
              ),
              const SizedBox(width: 16),
              SocialButton(
                icon: Icons.phone_outlined,
                url: 'tel:${AppConstants.phone}',
                tooltip: 'Call Phone',
              ),
            ],
          ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
        ],
      );
    }

    // Developer Headshot with glowing circles and floating icons matching mockup image
    Widget buildVisualSide() {
      return Center(
        child: SizedBox(
          width: 420,
          height: 420,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Concentric Ambient Glowing Ring 1
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.35),
                      Colors.transparent,
                    ],
                    radius: 0.8,
                  ),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.2),
                    width: 2.0,
                  ),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .rotate(duration: 25.seconds, begin: 0, end: 1),

              // // Concentric Ambient Glowing Ring 2
              // Container(
              //   width: 285,
              //   height: 285,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: AppColors.secondary.withOpacity(0.15),
              //       width: 1.5,
              //     ),
              //   ),
              // ).animate(onPlay: (controller) => controller.repeat())
              //   .rotate(duration: 20.seconds, begin: 1, end: 0),

              // The Headshot Avatar Image cropped inside a clean circle
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.4),
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ).animate()
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0), duration: 1.seconds, curve: Curves.easeOutBack)
                .fadeIn(duration: 800.ms),

              // Floating Badge 1: Flutter Logo (Top Left)
              Positioned(
                top: 50,
                left: 40,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withOpacity(0.9),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary.withOpacity(0.6), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.flutter,
                      color: Color(0xFF02569B),
                      size: 22,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .slideY(begin: 0.1, end: -0.1, duration: 3.seconds, curve: Curves.easeInOut),
              ),

              // Floating Badge 2: Dart Logo / Icon (Bottom Left)
              Positioned(
                bottom: 80,
                left: 30,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withOpacity(0.9),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.cyan.withOpacity(0.6), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.code_rounded,
                      color: Colors.cyan,
                      size: 20,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .slideY(begin: -0.1, end: 0.1, duration: 2.5.seconds, curve: Curves.easeInOut),
              ),

              // Floating Badge 3: Firebase Logo (Middle Right)
              Positioned(
                top: 140,
                right: 30,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withOpacity(0.9),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber.withOpacity(0.6), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.fire,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .slideY(begin: 0.08, end: -0.08, duration: 3.2.seconds, curve: Curves.easeInOut),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height - 70, // Account for navbar height
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Responsive(
            mobile: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildVisualSide(),
                const SizedBox(height: 48),
                buildIntroText(),
              ],
            ),
            desktop: Row(
              children: [
                Expanded(child: buildIntroText()),
                Expanded(child: buildVisualSide()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
