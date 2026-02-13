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
import 'view/skill_section.dart';
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

/// 1. AssetFinder를 사용해서 asset을 사용하는 클래스 리펙토링
/// -> 포트폴리오의 수정이 필요할 시 파일의 추가/삭제만으로 포토폴리오를 핸들링 하기 위함
/// -> 기존은 asset 파일을 추가하면 코드를 추가해야 함 (비효율)
/// -> 마크다운, Skill Ball 추가를 유동적으로 가져갈 수 있음
