import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../extension/theme_extension.dart';
import '../widget/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(
        vertical: 150,
      ),
      child: Column(
        mainAxisAlignment: .center,
        spacing: 30,
        children: [
          const SectionTitle(
            showDivider: false,
            title: 'Contact',
            subtitle:
                '저와 함께 작업하고 싶거나, 더 많은 정보를 원하신다면 언제든지 연락주세요.\n'
                '새로운 기회를 기다리고 있습니다!',
          ),
          ElevatedButton.icon(
            onPressed: () => context.push('/email-dialog'),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 24,
              ),
              foregroundColor: Colors.white,
              iconColor: Colors.white,
              backgroundColor: context.colorTheme.primary,
              textStyle: GoogleFonts.notoSansKr(
                textStyle: context.textTheme.buttonText,
                height: 1.5,
              ),
            ),
            icon: const Icon(Icons.email),
            label: const Text('Send Email'),
          ),
        ],
      ),
    );
  }
}

class EmailSendDialog extends StatelessWidget {
  const EmailSendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      color: Colors.blueAccent,
    );
  }
}

