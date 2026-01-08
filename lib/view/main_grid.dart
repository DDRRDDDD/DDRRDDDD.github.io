import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../extension/grid_extension.dart';
import '../widget/animate_named_grid_placement.dart';
import '../widget/bento_container.dart';
import 'about_section.dart';
import 'bento_grid_scaffold.dart';
import 'hero_section.dart';
import 'info_section.dart';
import 'skill_section.dart';
import 'social_section.dart';

class MainGrid extends StatelessWidget {
  const MainGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.05,
        vertical: BentoGridScaffold.verticalPadding,
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
            const AnimateNamedGridPlacement(
              order: 2,
              areaName: 'hero',
              child: HeroSection(),
            ),
            const AnimateNamedGridPlacement(
              order: 3,
              areaName: 'social',
              child: SocialSection(),
            ),
            const AnimateNamedGridPlacement(
              order: 5,
              areaName: 'about',
              child: AboutSection(),
            ),
            const AnimateNamedGridPlacement(
              order: 1,
              areaName: 'skill',
              child: SkillSection(),
            ),
            const AnimateNamedGridPlacement(
              order: 4,
              areaName: 'info',
              child: PersonalInfoBentoCard(),
            ),
          ],
        ),
      ),
    );
  }
}
