import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../widgets/glass_card.dart';
import '../widgets/social_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Get In Touch',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s Connect',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 32,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Feel free to reach out for collaborations, project inquiries, or just to say hello!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget buildContactCards() {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Card 1: Status Box (Mockup style with green glowing indicator)
          GlassCard(
            width: context.isMobile ? double.infinity : 320,
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            animateOnHover: true,
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success,
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'I\'m currently open to new opportunities. Let\'s build something amazing together!',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Card 2: Email Card (Mockup style)
          GestureDetector(
            onTap: () => _launchUrl('mailto:${AppConstants.email}'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GlassCard(
                width: context.isMobile ? double.infinity : 220,
                height: 130,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                animateOnHover: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.email_outlined, color: AppColors.primary, size: 22),
                    const SizedBox(height: 12),
                    const Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConstants.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Card 3: Phone Card (Mockup style)
          GestureDetector(
            onTap: () => _launchUrl('tel:${AppConstants.phone}'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GlassCard(
                width: context.isMobile ? double.infinity : 220,
                height: 130,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                animateOnHover: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.phone_outlined, color: AppColors.primary, size: 22),
                    const SizedBox(height: 12),
                    const Text(
                      'Phone',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConstants.phone,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Card 4: Location Card (Mockup style)
          GlassCard(
            width: context.isMobile ? double.infinity : 220,
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            animateOnHover: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 22),
                const SizedBox(height: 12),
                const Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  AppConstants.location,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Card 5: Social handles container (Mockup style)
          GlassCard(
            width: context.isMobile ? double.infinity : 220,
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            animateOnHover: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialButton(
                  icon: FontAwesomeIcons.github,
                  url: AppConstants.githubUrl,
                  tooltip: 'GitHub',
                ),
                SocialButton(
                  icon: FontAwesomeIcons.linkedinIn,
                  url: AppConstants.linkedinUrl,
                  tooltip: 'LinkedIn',
                ),
                SocialButton(
                  icon: Icons.email_outlined,
                  url: 'mailto:${AppConstants.email}',
                  tooltip: 'Email',
                ),
                SocialButton(
                  icon: FontAwesomeIcons.whatsapp,
                  url: AppConstants.whatsappUrl,
                  tooltip: 'WhatsApp',
                ),
              ],
            ),
          ),
        ],
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
              buildContactCards(),
            ],
          ),
        ),
      ),
    );
  }
}
