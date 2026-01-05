import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../extension/grid_extension.dart';
import '../extension/theme_extension.dart';
import '../widget/navigation_bar.dart';
import 'about_section.dart';
import 'hero_section.dart';
import 'info_section.dart';
import 'skill_section.dart';
import 'social_section.dart';

class BentoGrid extends StatelessWidget {
  static const double bentoWidth = 240;
  static const double bentoHeight = 220;
  static const double bentoGap = 20;

  const BentoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.colorTheme.background,
      floatingActionButtonLocation: const NavigationBarLocation(),
      floatingActionButton: const FloatingNavigationBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
          vertical: 50,
        ),
        child: Center(
          child: LayoutGrid(
            areas: '''
                  hero    hero   skill  social  
                  hero    hero   skill  info
                  about   about  about  about   
                  ''',
            columnSizes: bentoWidth.px * 4,
            rowSizes: bentoHeight.px * 3,
            columnGap: bentoGap,
            rowGap: bentoGap,
            children: [
              const NamedAreaGridPlacement(
                areaName: 'hero',
                child: HeroSection(),
              ),
              const NamedAreaGridPlacement(
                areaName: 'social',
                child: SocialSection(),
              ),
              const NamedAreaGridPlacement(
                areaName: 'about',
                child: AboutSection(),
              ),
              const NamedAreaGridPlacement(
                areaName: 'skill',
                child: SkillSection(),
              ),
              const NamedAreaGridPlacement(
                areaName: 'info',
                child: InfoSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BentoContainer extends StatelessWidget {
  static const EdgeInsets contentPadding = EdgeInsets.all(24);

  static const BorderRadius borderRadius = BorderRadius.all(
    Radius.circular(24),
  );

  const BentoContainer({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color = Colors.transparent,
    required this.child,
  });

  final double width;
  final double height;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}
