import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/overlays.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/profile/data/models/profile_menu_item.dart';
import 'package:shefaa/features/profile/presentation/view/widgets/profile_menu_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/user_edit_avatar.dart';
part 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h16,
      children: [
        Gap.medium() ,
        const _ProfileHeader(),
        BlocBuilder(
            bloc: sessionCubit,
            builder:(_,_)=> ProfileMenuList(items: _items())),
      ],
    ).paddingAll;
  }
}

List<ProfileMenuItem> _items() => [
  if(!sessionCubit.isGuest)...[
    ProfileMenuItem(
      icon: AppIcons.profile,
      title: "الملف الشخصي",
      onTap: (context) => context.pushNamed(Routes.editProfile),
    ),
    ProfileMenuItem(
      icon: AppIcons.wallet,
      title: "وسائل الدفع",
      onTap: (context) => context.pushNamed(Routes.myPayMethod),
    ),
     ProfileMenuItem(
      icon: AppIcons.locationFilled,
      title: "العناوين المحفوظة",
      onTap: (c)=>c.pushNamed(Routes.myLocations)
    ),
  ],
  ProfileMenuItem(
    icon: AppIcons.settings,
    title: "الإعدادات",
    onTap: (context) => context.pushNamed(Routes.settings),
  ),
  ProfileMenuItem(
    icon: AppIcons.error,
    title: "المساعدة",
    onTap: (context) {
      // Navigate to help
    },
  ),
  ProfileMenuItem(
    icon: AppIcons.lock,
    title: "سياسة الخصوصية",
    onTap: (context) {
      // Navigate to privacy policy
    },
  ),
  if(!sessionCubit.isGuest)
    ProfileMenuItem(
    icon: AppIcons.logout,
    title: "تسجيل خروج",
    onTap: (context) async{
     final result = await  context.showWarningBottomSheet(
        title: "تأكيد تسجيل الخروج",
        message:  "هل تريد تسجيل الخروج من حسابك؟ يمكنك تسجيل الدخول مرة أخرى في أي وقت.",
      );
     if(result) sessionCubit.signOut() ;

    },
  ),
];
