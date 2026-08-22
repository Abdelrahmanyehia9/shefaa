import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/features/auth/presentation/controller/sign_in_email_and_password_cubit.dart';
import 'package:shefaa/features/auth/presentation/view/forms/sign_in_form.dart';
import 'package:shefaa/shared/presentation/view/layout/auth_layout.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/toggle_sign_in_and_signup.dart';
import 'package:shefaa/features/auth/presentation/view/widgets/social_login.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> onSignIn() async {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<SignInEmailAndPasswordCubit>();
    await cubit.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<SignInEmailAndPasswordCubit, String>(
      onLoading: context.loaderOverlay.show,
      onLoaded: (s) {
        if (s.isFailure) context.errorBar(s.error!);
        context.loaderOverlay.hide();
      },
      builder: (s) => AppScaffold(
        hPadding: 0,
        bottomPadding: false,
        body: AuthLayout(
          showLogo: true,
          title: "تسجيل الدخول",
          description: "سجّل دخولك للمتابعة والاستمتاع بتجربة  أسهل وأسرع.",
          action: AppButton.filled("تسجيل الدخول", onTap: onSignIn),
          form: SignInForm(
            emailController: _emailController,
            passwordController: _passwordController,
            formKey: _formKey,
          ),
          footer: const Column(
            children: [SocialLogin(), ToggleSignInAndSignup()],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
