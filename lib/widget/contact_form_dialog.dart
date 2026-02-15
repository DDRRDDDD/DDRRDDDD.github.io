import 'package:flutter/material.dart';
import 'package:font_kit/font_kit.dart';
import 'package:go_router/go_router.dart';

import '../datasource/email_manager.dart';
import '../extension/theme_extension.dart';
import 'bento_container.dart';

class ContactFormDialog extends StatefulWidget {
  const ContactFormDialog({super.key});

  @override
  State<ContactFormDialog> createState() {
    return _ContactFormDialogState();
  }
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  late final GlobalKey<FormState> _formKey;

  String title = '';
  String email = '';
  String message = '';

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Constraints.inputTitle.label;
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Constraints.inputEmail.label;
    }

    if (!EmailService.emailRegex.hasMatch(value)) {
      return Constraints.invalidEmailFormat.label;
    }

    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Constraints.inputMessage.label;
    }

    return null;
  }

  void _method() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final EmailPayload payload = EmailPayload(
        title: title,
        fromEmail: email,
        message: message,
      );
      EmailService().sendEmail(payload);
      context.pop(); // TODO checkmark.riv
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InputFieldContainer(
      child: SizedBox(
        height: BentoContainer.spanHeight(3),
        width: BentoContainer.spanWidth(2),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: .center,
              spacing: 12,
              children: [
                TextFormField(
                  initialValue: title,
                  onSaved: (value) => title = value ?? '',
                  validator: _validateTitle,
                  decoration: InputDecoration(
                    labelText: Constraints.title.label,
                  ),
                ),
                TextFormField(
                  initialValue: email,
                  onSaved: (value) => email = value ?? '',
                  validator: _validateEmail,
                  decoration: InputDecoration(
                    labelText: Constraints.email.label,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    textAlignVertical: .top,
                    initialValue: message,
                    onSaved: (value) => message = value ?? '',
                    validator: _validateMessage,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: Constraints.inquiryContent.label,
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
                      ),
                      child: Text(
                        Constraints.cancel.label,
                        style: context.textTheme.heroBadge,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _method,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.all(16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        backgroundColor: context.colorTheme.secondary,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        Constraints.send.label,
                        style: context.textTheme.buttonText.copyWith(
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
          errorStyle: context.textTheme.labelMedium.copyWith(
            color: Colors.redAccent,
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
