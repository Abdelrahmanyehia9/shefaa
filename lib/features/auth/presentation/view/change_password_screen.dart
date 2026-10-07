import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/auth/presentation/controller/change_password_cubit.dart';
import 'package:shefaa/features/auth/presentation/view/forms/change_password_form.dart';
import 'package:shefaa/shared/presentation/view/layout/auth_layout.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future<void>_changePassword()async{
    if(_formKey.currentState?.validate()??false){
      context.read<ChangePasswordCubit>().changePassword(newPassword: _passwordController.text) ;
    }
  }



  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      bottomPadding: false,
      appBar: AppBar(),
      body: BaseBlocConsumer<ChangePasswordCubit, Unit>(
        onLoading: context.loaderOverlay.show,
        onLoaded: (s){
          context.loaderOverlay.hide() ;
          if(s.isSuccess) {
          _passwordController.clear();
          _passwordConfirmController.clear() ;
          _formKey.currentState?.reset() ;
            return context.successBar(message: "تم تغيير كلمة المرور بنجاح");
          }
          if(s.isFailure){
            return context.errorBar(s.error!);
          }
        },
        builder:(_) => AuthLayout(
          title: "تعيين كلمة مرور جديدة",
          description:
              "أدخل كلمة مرور جديدة وقوية لتأمين حسابك والحفاظ على بياناتك الشخصية بأمان.",
          form: ChangePasswordForm(
            formKey: _formKey,
            passwordController: _passwordController,
            passwordConfirmController: _passwordConfirmController,
          ),
          action: AppButton.filled("تاكيد", onTap: _changePassword,),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController. dispose();
    _passwordConfirmController. dispose();
    super.dispose();
  }
}
