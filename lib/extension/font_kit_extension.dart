import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_kit/font_kit.dart';
import 'package:recase/recase.dart';

/// `ProjectIcon` 열거형 값과 실제 `IconData`를 매핑하는 익스텐션.
/// 각 프로젝트 아이콘을 Flutter/FontAwesome 아이콘으로 변환한다.
extension ProjectIconMapper on ProjectIcon {
  IconData get data {
    return switch (this) {
      ProjectIcon.smartphone => Icons.smartphone,
      ProjectIcon.flag => Icons.flag,
      ProjectIcon.code => Icons.code,
      ProjectIcon.apple => Icons.apple_outlined,
      ProjectIcon.github => FontAwesomeIcons.github,
    };
  }
}

extension Projects on Project {
  bool get hasTeamSummary {
    return myContribution != null ||
        teamSummaries != null && teamSummaries!.isNotEmpty;
  }

  String get markdownAsset {
    return 'assets/md/${name.paramCase}/';
  }

  bool matchesMarkdown(String assetPath) {
    return assetPath.startsWith(markdownAsset) &&
        assetPath.toLowerCase().endsWith('.md');
  }
}