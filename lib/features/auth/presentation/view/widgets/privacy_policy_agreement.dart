import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/utils/text_styles.dart';

class PrivacyPolicyAgreement extends StatefulWidget {
  const PrivacyPolicyAgreement({super.key});

  @override
  State<PrivacyPolicyAgreement> createState() => _PrivacyPolicyAgreementState();
}

class _PrivacyPolicyAgreementState extends State<PrivacyPolicyAgreement> {
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _privacyRecognizer = TapGestureRecognizer()..onTap = _onPrivacyTap;
  }

  void _onPrivacyTap() {}

  @override
  Widget build(BuildContext context) {
    final baseStyle = context.textTheme.bodySmall?.copyWith(height: 0);

    final linkStyle = baseStyle?.copyWith(
      decoration: TextDecoration.underline,
      fontWeight: FontWeightHelper.bold,
      color: context.colors.primary,
    );

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: baseStyle,
        text: "بإنشاء حساب، فإنك توافق على ",
        children: [
          TextSpan(
            text: "سياسة الخصوصية",
            style: linkStyle,
            recognizer: _privacyRecognizer,
          ),
          const TextSpan(text: " الخاصة بنا وكيفية استخدامنا لبياناتك."),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _privacyRecognizer.dispose();
    super.dispose();
  }
}
