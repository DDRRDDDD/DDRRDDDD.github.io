import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../extension/theme_extension.dart';
import 'bento_grid.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: .spaceBetween,
      runAlignment: .spaceBetween,
      spacing: BentoGrid.bentoGap,
      runSpacing: BentoGrid.bentoGap,
      children: [
        BentoContainer(
          width: (BentoGrid.bentoWidth - BentoGrid.bentoGap) / 2,
          height: (BentoGrid.bentoHeight - BentoGrid.bentoGap) / 2,
          color: context.colorTheme.textMain,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.github,
              color: context.colorTheme.background,
              size: 40,
            ),
          ),
        ),
        BentoContainer(
          width: (BentoGrid.bentoWidth - BentoGrid.bentoGap) / 2,
          height: (BentoGrid.bentoHeight - BentoGrid.bentoGap) / 2,
          color: context.colorTheme.textMain,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.bloggerB,
              color: context.colorTheme.background,
              size: 40,
            ),
          ),
        ),
        BentoContainer(
          height: (BentoGrid.bentoHeight - BentoGrid.bentoGap) / 2,
          width: BentoGrid.bentoWidth,
          color: context.colorTheme.textSub,
          child: Center(
            child: Text(
              'Contact Me',
              style: context.textTheme.sectionTitle.copyWith(
                color: context.colorTheme.background,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
