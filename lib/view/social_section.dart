import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../extension/theme_extension.dart';
import '../widget/bento_container.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: .spaceBetween,
      runAlignment: .spaceBetween,
      spacing: BentoContainer.bentoGap,
      runSpacing: BentoContainer.bentoGap,
      children: [
        BentoContainer(
          width: (BentoContainer.bentoWidth - BentoContainer.bentoGap) / 2,
          height: (BentoContainer.bentoHeight - BentoContainer.bentoGap) / 2,
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
          width: (BentoContainer.bentoWidth - BentoContainer.bentoGap) / 2,
          height: (BentoContainer.bentoHeight - BentoContainer.bentoGap) / 2,
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
          height: (BentoContainer.bentoHeight - BentoContainer.bentoGap) / 2,
          width: BentoContainer.bentoWidth,
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
