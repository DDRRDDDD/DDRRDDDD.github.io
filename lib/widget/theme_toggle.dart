import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';
import '../extension/theme_extension.dart';
import 'theme_mode_provider.dart';

typedef BrightnessButtonStyle = ({
  IconData icon,
  Color iconColor,
  Color backgroundColor,
});

class BrightnessToggle extends StatefulWidget {
  const BrightnessToggle({super.key});

  @override
  State<BrightnessToggle> createState() => _BrightnessToggleState();
}

class _BrightnessToggleState extends State<BrightnessToggle>
    with SingleTickerProviderStateMixin {
  static const double _lightModeOffset = 0.5; // 뒤집힌 상태 (180도)
  static const double _darkModeOffset = 0.0;  // 정위치 (0도)

  static const double _halfTurn = 0.5;

  double _turns = double.nan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Brightness mode = BrightnessModel.valueOf(context);
    final bool isLight = mode.isLight;

    if (_turns.isNaN) {
      _turns = isLight ? _lightModeOffset : _darkModeOffset;
      return;
    }

    final bool visuallyDark = _turns % 1 == _darkModeOffset;

    if (isLight == visuallyDark) {
      _turns += _halfTurn;
    }
  }

  /// (Wrap 간격 + 버튼 크기) 만큼 오른쪽으로 밀어야 함
  @override
  Widget build(BuildContext context) {
    const double fabInset = -30.0;
    const double buttonSize = _BrightnessActionButton.buttonSize;
    final double spacing = MediaQuery.sizeOf(context).width * 0.3;

    return Transform.translate(
      offset: Offset(spacing + buttonSize + fabInset, fabInset),
      child: AnimatedRotation(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutBack,
        turns: _turns,
        child: Wrap(
          alignment: .center,
          crossAxisAlignment: .center,
          spacing: spacing,
          children: [
            const _BrightnessActionButton(mode: .dark),
            const _BrightnessActionButton(mode: .light),
          ],
        ),
      ),
    );
  }
}

class _BrightnessActionButton extends StatelessWidget {
  static const double buttonSize = 56.0;
  static const double iconSize = 30.0;

  const _BrightnessActionButton({
    super.key,
    required this.mode,
  });

  final Brightness mode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => BrightnessModel.of(context).value = mode.opposite,
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: context.colorTheme.primary,
          ),
          child: Center(
            child: Icon(
              mode.isLight ? Icons.light_mode : Icons.dark_mode,
              color: context.colorTheme.background,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
