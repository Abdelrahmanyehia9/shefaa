import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/profile/data/models/profile_menu_item.dart';
import 'package:shefaa/features/profile/presentation/view/widgets/profile_menu_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/user_edit_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: UISizes.h24,
      children: [
        _header(context),
         ProfileMenuList(
           items: _items(),
         )
      ],
    );
  }
  Widget _header(BuildContext context)=>Column(
    spacing: UISizes.h8,
    children: [
      UserEditAvatar(size: UISizes.sp96,),
      AppText("خالد عبدالرحمن", style: context.textTheme.labelLarge,),
    ],
  );
}


 List<ProfileMenuItem>_items() =>[
  ProfileMenuItem(
    icon: AppIcons.profile,
    title: "الملف الشخصي",
    onTap: (context) => context.pushNamed(Routes.editProfile)
  ),
  ProfileMenuItem(
    icon: AppIcons.favorite,
    title: "المفضلات",
    onTap: (context)=>context.pushNamed(Routes.favorite)
  ),
  ProfileMenuItem(
    icon: AppIcons.settings,
    title: "الإعدادات",
    onTap: (context) =>context.pushNamed(Routes.settings)
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
  ProfileMenuItem(
    icon: AppIcons.logout,
    title: "تسجيل خروج",
    onTap: (context) {
      // Logout
    },
  ),
];