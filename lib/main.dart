import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/providers.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'services/inquiry_storage_service.dart';

/// Application entry point.
/// Bootstraps Hive for local persistence, opens the inquiry storage box, then
/// injects the initialized service into the Riverpod provider tree via an
/// override before running the app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Hive.initFlutter();
  final InquiryStorageService storage =
      await InquiryStorageService.initialize();

  runApp(
    ProviderScope(
      overrides: <Override>[
        inquiryStorageProvider.overrideWithValue(storage),
      ],
      child: const MxWorldApp(),
    ),
  );
}

/// Root widget configuring theming and declarative routing.
class MxWorldApp extends StatelessWidget {
  const MxWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MX WORLD — Global Logistics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }
}
