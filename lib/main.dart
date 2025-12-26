import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bento_grid/bento_grid.dart';
import 'datasource/rive_file_manager.dart';
import 'datasource/svg_manager.dart';
import 'extension/brightness_extension.dart';
import 'theme/chip_color_theme.dart';
import 'theme/color_theme.dart';
import 'theme/text_theme.dart';
import 'widget/responsive_layout.dart';
import 'widget/theme_mode_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  GoogleFonts.config.allowRuntimeFetching = false;
  await Future.wait([
    RiveFileManager.init(),
    SvgManager.init(skillIconPaths),
  ]);
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {π
    return BrightnessProvider(
      builder: (_, brightness) => ResponsiveLayout(
        child: MaterialApp(
          title: '김용민 | 플러터 개발자',
          debugShowCheckedModeBanner: false,
          // routerConfig: router,
          home: const BentoGrid(),
          themeMode: brightness.themeMode,
          theme: ThemeData(
            splashFactory: NoSplash.splashFactory,
            extensions: [
              ColorThemeExtension.from(brightness),
              ChipColorThemeExtension.from(brightness),
              TextThemeExtension.defaultTheme(),
            ],
          ),
        ),
      ),
    );
  }
}

/// 웹 어셈블리 모드 --wasm
