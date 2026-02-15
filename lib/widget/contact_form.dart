import 'package:flutter/material.dart';
import 'package:font_kit/font_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../datasource/email_manager.dart';
import '../extension/theme_extension.dart';
import '../theme/text_field_theme.dart';
import 'bento_container.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() {
    return _ContactFormState();
  }
}

class _ContactFormState extends State<ContactForm> {
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

  Future<void> _onSendPressed() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    _formKey.currentState?.save();
    final EmailPayload payload = EmailPayload(
      title: title,
      fromEmail: email,
      message: message,
    );

    EmailService().sendEmail(payload);
    WoltModalSheet.of(context).showNext();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: TextFieldTheme.theme(context),
      child: SizedBox(
        height: BentoContainer.spanHeight(3),
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
                        padding: const EdgeInsets.all(16),
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
                      onPressed: _onSendPressed,
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
