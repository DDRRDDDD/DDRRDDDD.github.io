import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../route/route.dart';
import '../route/section_branch.dart';

extension RouteStateExtension on BuildContext {
  List<StatefulShellBranch> get _branches {
    return routeStateKey.currentState?.route.branches ?? [];
  }

  List<SectionBranch> get sectionBranches {
    return _branches.whereType<SectionBranch>().toList();
  }

  List<SectionBranch> get menuSectionBranches {
    return sectionBranches.where((branch) => branch.menuName != null).toList();
  }
}