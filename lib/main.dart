import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:rive_native/rive_native.dart';

import 'datasource/rive_manager.dart';
import 'extension/brightness_extension.dart';
import 'route/route.dart';
import 'theme/color_theme.dart';
import 'widget/responsive_layout.dart';
import 'widget/theme_mode_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await RiveNative.init();
  await RiveFileManager.init();
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BrightnessProvider(
      builder: (_, brightness) => ResponsiveLayout(
        child: MaterialApp.router(
          title: '김용민 | 플러터 개발자',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          themeMode: brightness.themeMode,
          theme: ThemeData(
            splashFactory: NoSplash.splashFactory,
            extensions: [
              ColorThemeExtension.from(brightness),
            ],
          ),
        ),
      ),
    );
  }
}
