import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../extension/grid_extension.dart';
import '../extension/theme_extension.dart';
import '../widget/bento_container.dart';
import '../widget/navigation_bar.dart';
import 'about_section.dart';
import 'hero_section.dart';
import 'info_section.dart';
import 'skill_section.dart';
import 'social_section.dart';

class MainGrid extends StatelessWidget {
  const MainGrid({super.key});

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
            columnSizes: BentoContainer.bentoWidth.px * 4,
            rowSizes: BentoContainer.bentoHeight.px * 3,
            columnGap: BentoContainer.bentoGap,
            rowGap: BentoContainer.bentoGap,
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
                child: PersonalInfoBentoCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
