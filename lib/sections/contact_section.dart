import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme_context.dart';
import '../widgets/glass_card.dart';
import '../widgets/social_button.dart';
import '../widgets/section_header.dart';

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
    Widget buildHeader() {
      return const SectionHeader(
        eyebrow: 'Get In Touch',
        icon: Icons.chat_bubble_outline_rounded,
        title: 'Let\'s Connect',
        subtitle: 'Feel free to reach out for collaborations, project inquiries, or just to say hello!',
      );
    }

    Widget buildInfoCard({
      required IconData icon,
      required String label,
      required String value,
      VoidCallback? onTap,
    }) {
      return GlassCard(
        width: context.isMobile ? double.infinity : 220,
        height: 130,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        animateOnHover: true,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: context.textSecondary),
            ),
          ],
        ),
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
                      color: context.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Card 2: Email Card
          buildInfoCard(
            icon: Icons.email_outlined,
            label: 'Email',
            value: AppConstants.email,
            onTap: () => _launchUrl('mailto:${AppConstants.email}'),
          ),

          // Card 3: Phone Card
          buildInfoCard(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: AppConstants.phone,
            onTap: () => _launchUrl('tel:${AppConstants.phone}'),
          ),

          // Card 4: Location Card
          buildInfoCard(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: AppConstants.location,
          ),

          // Card 5: Social handles container (Mockup style)
          GlassCard(
            // Wide enough for four 48px buttons with breathing room
            width: context.isMobile ? double.infinity : 280,
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
