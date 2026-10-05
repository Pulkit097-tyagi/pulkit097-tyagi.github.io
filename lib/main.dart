import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'core/constants.dart';
import 'core/theme.dart';
import 'providers/theme_provider.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Report visibility on the next frame rather than batching every 150ms, so
  // the About stats start counting the moment they scroll into view. Cheap:
  // only that one grid uses a VisibilityDetector.
  VisibilityDetectorController.instance.updateInterval = Duration.zero;
  
  runApp(
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: '${AppConstants.name} | ${AppConstants.title} Portfolio',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const AppMainShell(),
    );
  }
}
