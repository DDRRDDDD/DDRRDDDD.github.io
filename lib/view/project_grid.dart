import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../extension/grid_extension.dart';
import '../widget/animate_named_grid_placement.dart';
import '../widget/bento_container.dart';
import 'bento_grid_scaffold.dart';

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({super.key});

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
              main    main   item1     item1  
              main    main   sub_main  sub_main
              item2   item2  sub_main  sub_main   
              ''',
          columnSizes: BentoContainer.bentoWidth.px * 4,
          rowSizes: BentoContainer.bentoHeight.px * 3,
          columnGap: BentoContainer.bentoGap,
          rowGap: BentoContainer.bentoGap,
          children: [
            AnimateNamedGridPlacement(
              order: 1,
              areaName: 'main',
              child: _buildColoredBox(Colors.redAccent),
            ),
            AnimateNamedGridPlacement(
              order: 2,
              areaName: 'item1',
              child: _buildColoredBox(Colors.yellowAccent),
            ),
            AnimateNamedGridPlacement(
              order: 3,
              areaName: 'sub_main',
              child: _buildColoredBox(Colors.greenAccent),
            ),
            AnimateNamedGridPlacement(
              order: 4,
              areaName: 'item2',
              child: _buildColoredBox(Colors.purpleAccent),
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
