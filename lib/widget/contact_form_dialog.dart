import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extension/theme_extension.dart';
import 'bento_container.dart';

class ContactFormDialog extends StatelessWidget {
  const ContactFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return _InputFieldContainer(
      child: SizedBox(
        height: BentoContainer.bentoHeight * 3,
        width: BentoContainer.bentoWidth * 2 + BentoContainer.bentoGap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: '제목',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: '이메일',
                ),
              ),
              const Expanded(
                child: TextField(
                  expands: true,
                  maxLines: null,
                  textAlignVertical: .top,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: '문의 내용',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: .end,
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: context.pop,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(17),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      foregroundColor: context.colorTheme.textMain,
                      textStyle: context.textTheme.heroBadge,
                    ),
                    child: const Text('취소'),
                  ),
                  ElevatedButton(
                    onPressed: context.pop,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      backgroundColor: context.colorTheme.secondary,
                      foregroundColor: Colors.white,
                      textStyle: context.textTheme.buttonText.copyWith(
                        letterSpacing: 1.0,
                      ),
                    ),
                    child: const Text("보내기"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputFieldContainer extends StatelessWidget {
  const _InputFieldContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
          bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: context.colorTheme.textMain,
            fontSize: 12,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: context.textTheme.heroBadge.copyWith(
            color: context.colorTheme.textSub,
          ),
          floatingLabelStyle: context.textTheme.heroBadge.copyWith(
            color: context.colorTheme.textSub,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(
              color: context.colorTheme.outline,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(
              color: context.colorTheme.textMain,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.5,
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: context.colorTheme.textMain,
          selectionColor: context.colorTheme.outline,
        ),
      ),
      child: Dialog(
        backgroundColor: context.colorTheme.surfaceAlt,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: child,
      ),
    );
  }
}
