import 'package:flutter/material.dart';

import '../theme/color_theme.dart';
import 'theme_extension.dart';

const bool _add = true;
const bool _remove = false;

typedef WidgetStates = Set<WidgetState>;

extension WidgetStatesExtension on WidgetStates {
  bool get isHovered {
    return contains(WidgetState.hovered);
  }

  bool get isPressed {
    return contains(WidgetState.pressed);
  }
}

extension WidgetStatesControllerExtension on WidgetStatesController {
  void hoverOn() {
    update(WidgetState.hovered, _add);
  }

  void hoverOff() {
    update(WidgetState.hovered, _remove);
  }

  void pressOn() {
    update(WidgetState.pressed, _add);
  }

  void pressOff() {
    update(WidgetState.pressed, _remove);
  }
}

extension HoverEffectExtension on WidgetStates {
  Border hoverBorder(BuildContext context) {
    return Border.all(
      color: isHovered
          ? ColorThemeExtension.indigoVivid.withValues(alpha: 0.4)
          : context.colorTheme.outline,
    );
  }
}
