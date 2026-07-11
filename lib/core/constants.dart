import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/experience.dart';

class AppConstants {
  // Personal Info
  static const String name = 'Pulkit Tyagi';
  static const String title = 'Flutter Developer';
  static const List<String> techStackTitles = [
    'Flutter Developer',
    'Mobile App Developer',
    'Cross-Platform Engineer',
  ];
  
  static const String bio = 
      'Results-driven Flutter Developer with 2+ years of experience '
      'building scalable, high-performance Android & iOS applications '
      'using Flutter, Dart, and REST APIs.';

  static const String detailedBio = 
      'I\'m a results-driven Flutter Developer with 2+ years of experience '
      'developing production-grade mobile applications. Skilled in designing '
      'responsive UI/UX, optimizing app performance, and integrating third-party '
      'services such as payment gateways, automated KYC systems, real-time databases, '
      'and AI-based face recognition/detection workflows.';

  static const List<String> aboutBullets = [
    '2+ Years of Experience',
    'Clean Code & Best Practices',
    'AI Face Detection & KYC Integration',
    'Payment & IoT App Optimization',
  ];

  static const String email = 'tpulkit49@gmail.com';
  static const String phone = '+91 8533928469';
  static const String location = 'Noida, Uttar Pradesh';
  static const String cvUrl = 'https://example.com/resume.pdf'; // Resume placeholder
  
  // Social Links
  static const String githubUrl = 'https://github.com/pulkit-tyagi';
  static const String linkedinUrl = 'https://linkedin.com/in/pulkit-tyagi';
  static const String whatsappUrl = 'https://wa.me/918533928469';

  // Statistics
  static const List<Map<String, dynamic>> stats = [
    {'value': 2, 'label': 'Years Experience', 'suffix': '+', 'icon': Icons.calendar_today_outlined},
    {'value': 8, 'label': 'Projects Built', 'suffix': '', 'icon': Icons.code_rounded},
    {'value': 3, 'label': 'Apps Published', 'suffix': '', 'icon': Icons.phone_android_rounded},
    {'value': 100, 'label': 'Client Satisfaction', 'suffix': '%', 'icon': Icons.sentiment_satisfied_alt_outlined},
  ];

  // Skills Data
  static const List<Skill> skills = [
    Skill(name: 'Flutter', level: 0.95, category: SkillCategory.frameworks, iconData: FontAwesomeIcons.mobileScreen),
    Skill(name: 'Dart', level: 0.95, category: SkillCategory.languages, iconData: FontAwesomeIcons.code),
    Skill(name: 'C', level: 0.70, category: SkillCategory.languages, iconData: FontAwesomeIcons.terminal),
    Skill(name: 'Riverpod', level: 0.90, category: SkillCategory.frameworks, iconData: FontAwesomeIcons.layerGroup),
    Skill(name: 'Provider', level: 0.85, category: SkillCategory.frameworks, iconData: FontAwesomeIcons.shapes),
    Skill(name: 'GetX', level: 0.80, category: SkillCategory.frameworks, iconData: FontAwesomeIcons.objectGroup),
    Skill(name: 'Bloc', level: 0.85, category: SkillCategory.frameworks, iconData: FontAwesomeIcons.cubes),
    Skill(name: 'Firebase', level: 0.90, category: SkillCategory.cloud, iconData: FontAwesomeIcons.fire),
    Skill(name: 'SQLite', level: 0.85, category: SkillCategory.cloud, iconData: FontAwesomeIcons.database),
    Skill(name: 'Hive', level: 0.80, category: SkillCategory.cloud, iconData: FontAwesomeIcons.boxOpen),
    Skill(name: 'REST API', level: 0.95, category: SkillCategory.tools, iconData: FontAwesomeIcons.networkWired),
    Skill(name: 'Face Recognition', level: 0.85, category: SkillCategory.tools, iconData: FontAwesomeIcons.faceSmile),
    Skill(name: 'App Optimization', level: 0.90, category: SkillCategory.tools, iconData: FontAwesomeIcons.gaugeHigh),
    Skill(name: 'Git', level: 0.90, category: SkillCategory.tools, iconData: FontAwesomeIcons.gitAlt),
  ];

  // Projects Data
  static const List<Project> projects = [
    Project(
      title: 'Shunya Core App',
      imagePath: 'assets/images/shunya/logo.png',
      description: 'Employee management platform supporting face recognition attendance, seed prediction, and sales tracking. Available on iOS and Android.',
      tags: ['Flutter', 'AI Face Detection', 'SQLite', 'Google Maps', 'Push Notifications'],
      appScreenshot: ['assets/images/shunya/core_2.png', 'assets/images/shunya/core_1.png', 'assets/images/shunya/core_3.png'],
      androidUrl: 'https://play.google.com/store/apps/details?id=live.shunya.core&hl=en_IN',
      iosUrl: 'https://apps.apple.com/in/app/shunya-hydroponic-fodder/id6503728909',
      isFeatured: true,
      imageUrl: 'shunyacore',
    ),
    Project(
      title: 'Shunya Customer App',
      imagePath: 'assets/images/shunya/logo.png',
      description: 'Customer platform for order management, feed trading services, and secure transaction handling.',
      tags: ['Flutter', 'Order Management', 'REST API', 'Razorpay', 'Firebase'],
      appScreenshot: ['assets/images/shunya/customer_2.png', 'assets/images/shunya/customer_1.png', 'assets/images/shunya/customer_3.png'],
      // githubUrl: 'https://github.com/pulkit-tyagi',
      androidUrl: 'https://play.google.com/store/apps/details?id=com.shunya.shunya&hl=en_IN',
      iosUrl: 'https://apps.apple.com/in/app/shunya-hydroponic-fodder/id6503728909',
      isFeatured: true,
      imageUrl: 'shunyacore',
    ),
    Project(
      title: 'Shunya Saarthi App',
      imagePath: 'assets/images/shunya/logo.png',
      description: 'Business application for hydroponic product sales, inventory management, and business tracking.',
      tags: ['Flutter', 'Inventory Management', 'Agri-Tech', 'SQLite', 'REST API'],
      appScreenshot: ['assets/images/shunya/partner_2.png', 'assets/images/shunya/partner_1.png', 'assets/images/shunya/partner_3.png'],
      // githubUrl: 'https://github.com/pulkit-tyagi',
      androidUrl: 'https://play.google.com/store/apps/details?id=live.shunya.partner&hl=en_IN',
      iosUrl: 'https://apps.apple.com/in/app/shunya-saarthi/id6738115000',
      isFeatured: true,
      imageUrl: 'shunyacore',
    ),
    Project(
      title: 'HouseThat',
      imagePath: 'assets/images/housethat.png',
      description: 'Real estate application with dynamic property listings, robust search filters, and integrated agent contact.',
      tags: ['Flutter', 'Google Maps', 'REST API', 'Real-time Tracking', 'Firebase Messaging'],
      // githubUrl: 'https://github.com/pulkit-tyagi',
      // liveUrl: 'https://linkedin.com/in/pulkit-tyagi',
      isFeatured: true,
      imageUrl: 'housethat',
    ),
    Project(
      title: 'Dispatch App',
      imagePath: 'assets/images/dispatch.png',
      description: 'Real-time logistics and dispatch management application featuring automated Digio KYC verification and employee live-tracking.',
      tags: ['Flutter', 'Digio KYC', 'Google ML Kit', 'Payment Gateways', 'Live Tracking', 'REST API'],
      // githubUrl: 'https://github.com/pulkit-tyagi',
      // liveUrl: 'https://linkedin.com/in/pulkit-tyagi',
      isFeatured: true,
      imageUrl: 'dispatch',
    ),
    Project(
      title: 'UniHealth App',
      imagePath: 'assets/images/profile.png',
      description: 'Stable and user-friendly healthcare mobile applications providing digital solutions for patient services.',
      tags: ['Flutter', 'Riverpod', 'Healthcare', 'Firebase Auth', 'Data Sync'],
      // githubUrl: 'https://github.com/pulkit-tyagi',
      // liveUrl: 'https://linkedin.com/in/pulkit-tyagi',
      isFeatured: false,
      imageUrl: 'unihealth',
    ),
    Project(
      title: 'Data Collection App',
      imagePath: 'assets/images/profile.png',
      description: 'Mobile data collection tool featuring multipart file uploads and secure REST API transactions.',
      tags: ['Flutter', 'REST API', 'Multipart Uploads', 'Data Entry'],
      // githubUrl: 'https://github.com/pulkit-tyagi',
      // liveUrl: 'https://linkedin.com/in/pulkit-tyagi',
      isFeatured: false,
      imageUrl: 'datacollection',
    ),
    Project(
      title: 'One-to-One Chat Module',
      imagePath: 'assets/images/we_chat.png',
      description: 'Secure one-to-one real-time messaging chat module built with Firebase and Agora integrations.',
      tags: ['Flutter', 'Firebase Auth', 'Real-time Sync', 'Agora Video/Audio'],
      // githubUrl: 'https://github.com/pulkit-tyagi',
      // liveUrl: 'https://linkedin.com/in/pulkit-tyagi',
      isFeatured: false,
      imageUrl: 'wechat',
    ),
  ];

  // Experience Data
  static const List<Experience> experiences = [
    Experience(
      title: 'Flutter Developer',
      organization: 'Codenia Technologies',
      period: 'July 2025 - Present',
      description: 'Noida, Uttar Pradesh',
      type: ExperienceType.work,
      bulletPoints: [
        'Developed mobile applications (Android/iOS) including HouseThat, Dispatch App, and Data Collection App using Flutter.',
        'Integrated multiple REST APIs and third-party services such as Google APIs, Aadhaar, PAN verification, and multipart file uploads.',
        // 'Implemented AI-based face detection for attendance tracking and identity verification.',
        // 'Built live employee tracking system to monitor field staff activities from punch-in to punch-out.',
        'Integrated Digio KYC system enabling automated verification of Aadhaar, PAN, GST, and identity documents.',
      ],
    ),
    Experience(
      title: 'Flutter Developer',
      organization: 'Shunya Agritech Pvt Ltd',
      period: 'March 2024 - June 2025',
      description: 'Gurugram, Haryana',
      type: ExperienceType.work,
      bulletPoints: [
        'Developed and maintained Shunya Customer, Partner, and Core apps supporting IoT integrations and REST APIs.',
        // 'Designed responsive and scalable UI using Flutter with focus on smooth animations and performance optimization.',
        // 'Implemented multi-language support (English & Hindi) improving accessibility for regional users.',
        'Integrated Firebase services including authentication, real-time database, and push notifications.',
        'Added secure payment processing using Razorpay Payment Gateway.',
        'Implemented AI-based face recognition for employee attendance and verification workflows.',
      ],
    ),
    Experience(
      title: 'Flutter Developer',
      organization: 'Connex Infotech',
      period: 'Feb 2023 - March 2024',
      description: 'Zirakpur, Mohali',
      type: ExperienceType.work,
      bulletPoints: [
        'Developed UniHealth mobile applications delivering stable and user-friendly healthcare solutions.',
        'Implemented scalable architecture using Riverpod for state management.',
        // 'Integrated Firebase authentication, push notifications, and real-time data synchronization.',
        // 'Built one-to-one chat module using Firebase for secure real-time messaging.',
      ],
    ),
    Experience(
      title: 'Bachelor of Commerce',
      organization: 'Chaudhary Charan Singh University',
      period: '2020 - 2023',
      description: 'Meerut, India',
      type: ExperienceType.education,
    ),
  ];
}
