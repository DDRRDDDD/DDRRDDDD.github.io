import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'theme_mode_provider.dart';

typedef ThemeButtonStyle = ({
  IconData icon,
  Color iconColor,
  Color backgroundColor,
});

class ThemeModeToggle extends StatefulWidget {
  const ThemeModeToggle({super.key});

  @override
  State<ThemeModeToggle> createState() => _ThemeModeToggleState();
}

class _ThemeModeToggleState extends State<ThemeModeToggle>
    with SingleTickerProviderStateMixin {
  double _turns = double.nan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_turns.isNaN) {
      final ThemeMode mode = ThemeModel.of(context).value;
      _turns = mode == ThemeMode.light ? 0.5 : 0.0;
      return;
    }

    _turns += 0.5;
  }

  /// (Wrap 간격 + 버튼 크기) 만큼 오른쪽으로 밀어야 함
  @override
  Widget build(BuildContext context) {
    const double fabInset = -30.0;
    const double buttonSize = _ThemeModeActionButton.buttonSize;
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
            const _ThemeModeActionButton(
              mode: .dark,
            ),
            const _ThemeModeActionButton(
              mode: .light,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeActionButton extends StatelessWidget {
  static const double buttonSize = 56.0;
  static const double iconSize = 30.0;

  const _ThemeModeActionButton({
    super.key,
    required this.mode,
  });

  final ThemeMode mode;

  @override
  Widget build(BuildContext context) {
    final ThemeButtonStyle buttonStyle = mode.buttonStyle;
    
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => ThemeModel.of(context).value = mode.opposite,
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: buttonStyle.backgroundColor,
          ),
          child: Center(
            child: Icon(
              buttonStyle.icon,
              color: buttonStyle.iconColor,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}

extension _ThemeModeExtension on ThemeMode {
  ThemeMode get opposite {
    return this == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeButtonStyle get buttonStyle {
    return switch(this) {
      ThemeMode.light => (
          icon: Icons.wb_sunny_rounded,
          iconColor: AppColors.lightBackground,
          backgroundColor: AppColors.lightPrimary,
        ),
      ThemeMode.dark => (
          icon: Icons.nights_stay,
          iconColor: AppColors.darkBackground,
          backgroundColor: AppColors.darkPrimary,
        ),
      ThemeMode.system => throw UnimplementedError(),
    };
  }
}
