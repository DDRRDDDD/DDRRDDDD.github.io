import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'datasource/rive_file_manager.dart';
import 'datasource/svg_manager.dart';
import 'extension/brightness_extension.dart';
import 'route/route.dart';
import 'theme/chip_theme.dart';
import 'theme/color_theme.dart';
import 'theme/text_theme.dart';
import 'view/skill_section.dart';
import 'widget/grid_dot_background.dart';
import 'widget/theme_mode_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Future.wait([
    RiveFileManager.init(),
    SvgManager.init(SkillOptions.allAssetPaths),
  ]);
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BrightnessProvider(
      builder: (_, brightness) => MaterialApp.router(
        title: '김용민 | 플러터 개발자',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: GridDotContainer.background,
        themeMode: brightness.themeMode,
        theme: ThemeData(
          fontFamily: 'Noto_Sans',
          splashFactory: NoSplash.splashFactory,
          scaffoldBackgroundColor: Colors.transparent,
          extensions: [
            ColorThemeExtension.from(brightness),
            ChipColorThemeExtension.from(brightness),
            TextThemeExtension.defaultTheme(),
          ],
        ),
      ),
    );
  }
}

// https://ddrrdddd.github.io/