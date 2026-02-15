import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';

class TextFieldTheme {
  const TextFieldTheme._();

  static ThemeData theme(BuildContext context) {
    final ThemeData baseTheme = Theme.of(context);

    return baseTheme.copyWith(
      textTheme: baseTheme.textTheme.copyWith(
        bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(
          color: context.colorTheme.textMain,
          fontSize: 12,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: context.textTheme.heroBadge.copyWith(
          color: context.colorTheme.textSub,
        ),
        errorStyle: context.textTheme.labelMedium.copyWith(
          color: Colors.redAccent,
        ),
        floatingLabelStyle: context.textTheme.heroBadge.copyWith(
          color: context.colorTheme.textSub,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: context.colorTheme.outline,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: context.colorTheme.textMain,
            width: 1.5,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Colors.redAccent,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: context.colorTheme.textMain,
        selectionColor: context.colorTheme.outline,
      ),
    );
  }
}