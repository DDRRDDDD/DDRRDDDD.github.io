import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../extension/grid_extension.dart';
import '../widget/animate_named_grid_placement.dart';
import '../widget/bento_container.dart';
import 'bento_grid_scaffold.dart';
import 'project_my_portfolio_section.dart';
import 'project_my_turn_section.dart';
import 'project_one_hour_section.dart';

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: BentoGridScaffold.verticalPadding,
      ),
      child: Center(
        child: LayoutGrid(
          areas: '''
              item    item   sub_main  sub_main  
              main    main   sub_main  sub_main
              main    main   sub_main  sub_main   
              ''',
          columnSizes: BentoContainer.bentoWidth.px * 4,
          rowSizes: BentoContainer.bentoHeight.px * 3,
          columnGap: BentoContainer.bentoGap,
          rowGap: BentoContainer.bentoGap,
          children: [
            const AnimateNamedGridPlacement(
              order: 1,
              areaName: 'item',
              child: ProjectMyPortfolioSection(),
            ),
            const AnimateNamedGridPlacement(
              order: 2,
              areaName: 'sub_main',
              child: ProjectMyTurnSection(),
            ),
            const AnimateNamedGridPlacement(
              order: 4,
              areaName: 'main',
              child: ProjectOneHourSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColoredBox(Color color) {
    return BentoContainer(
      color: color,
      child: const SizedBox.shrink(),
    );
  }
}
