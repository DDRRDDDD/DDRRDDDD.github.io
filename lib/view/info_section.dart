import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import 'bento_grid.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BentoContainer(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            '인적 사항',
            style: context.textTheme.cardTitle.copyWith(
              color: Colors.white,
            ),
          ),
          const Gap(16),
          const _InfoRow(
            title: '오픈 소스 기여 경험',
            contents: ['WebDriverManager 프로젝트 PR'],
          ),
          const Gap(8),
          const _InfoRow(
            title: '자격증 보유',
            contents: ['정보처리산업기사 보유'],
          ),
        ],
      ),
    );
  }
}

// '자격증 및 오픈 소스 영역',

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    super.key,
    required this.title,
    required this.contents,
  });

  final String title;
  final List<String> contents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          '$title ',
          style: context.textTheme.bodyRegular.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const Gap(4),
        ...List.generate(
          contents.length,
          (index) => Row(
            crossAxisAlignment: .start,
            children: [
              Text(
                '•  ',
                style: context.textTheme.bodyRegular.copyWith(
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  contents.elementAt(index),
                  style: context.textTheme.bodyRegular.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
