import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'datasource/asset_finder.dart';
import 'datasource/font_manager.dart';
import 'datasource/rive_file_manager.dart';
import 'datasource/svg_manager.dart';
import 'extension/brightness_extension.dart';
import 'route/route.dart';
import 'theme/chip_theme.dart';
import 'theme/code_syntax_theme.dart';
import 'theme/color_theme.dart';
import 'theme/gradient_theme.dart';
import 'theme/text_theme.dart';
import 'widget/grid_dot_background.dart';
import 'widget/theme_mode_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Future.wait([
    FontManager.load(),
    AssetFinder.init(),
  ]);

  await Future.wait([
    RiveFileManager.init(),
    SkillSvgManager.init(),
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
          fontFamily: FontManager.notoSansFamily,
          fontFamilyFallback: [FontManager.notoSansEmojiFamily],
          splashFactory: NoSplash.splashFactory,
          scaffoldBackgroundColor: Colors.transparent,
          extensions: [
            ColorThemeExtension.from(brightness),
            ChipColorThemeExtension.from(brightness),
            GradientThemeExtension.from(brightness),
            CodeSyntaxThemeExtension.from(brightness),
            TextThemeExtension.defaultTheme(),
          ],
        ),
      ),
    );
  }
}

// https://ddrrdddd.github.io/

/// 이메일 매니저 구현
/// -> 이메일 보내기 완료 후 checkmark.riv 연결

/// 마크다운 pre load 구현
/// -> 프리로드 구현 후 아직도 시트가 버벅이면 AnimatedFade? 다시 구현

