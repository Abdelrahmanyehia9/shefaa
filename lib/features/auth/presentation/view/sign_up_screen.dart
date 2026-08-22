import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_up_email_and_password_cubit.dart';
import 'package:shefaa/features/auth/presentation/view/forms/sign_up_form.dart';
import 'package:shefaa/shared/presentation/view/layout/auth_layout.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/toggle_sign_in_and_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> onSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<SignUpEmailAndPasswordCubit>();
    await cubit.signup(
      fName: _firstNameController.text.trim(),
      lName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<SignUpEmailAndPasswordCubit, String>(
      onLoading: context.loaderOverlay.show,
      onLoaded: (s) {
        if (s.isFailure) context.errorBar(s.error!);
        context.loaderOverlay.hide();
      },
      builder: (_) => AppScaffold(
        hPadding: 0,
        bottomPadding: false,
        body: AuthLayout(
          showLogo: true,
          title: "انشاء حساب",
          description: "أنشئ حسابك وابدأ في إدارة خدماتك الطبية بسهولة.",
          form: SignUpForm(
            formKey: _formKey,
            firstName: _firstNameController,
            lastName: _lastNameController,
            email: _emailController,
            password: _passwordController,
          ),
          action: AppButton.filled("تسجيل", onTap: onSignUp),
          footer: const ToggleSignInAndSignup(isSignup: true).paddingVr,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
