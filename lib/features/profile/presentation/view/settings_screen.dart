import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_switch.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/profile/data/models/profile_menu_item.dart';
import 'package:shefaa/features/profile/presentation/view/widgets/profile_menu_list.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const AppText("الاعدادات")),
      body: ProfileMenuList(
        items: _items(
          notificationSwitcher: AppSwitch(value: true, onChanged: (_) {}),
        ),
      ),
    );
  }
}

List<ProfileMenuItem> _items({required Widget notificationSwitcher}) => [
  ProfileMenuItem(
    icon: AppIcons.notification,
    title: " الاشعارات",
    customTrailing: notificationSwitcher,
  ),
  ProfileMenuItem(
    icon: AppIcons.password,
    title: "تغيير كلمة المرور",
    onTap: (context) => context.pushNamed(Routes.changePassword),
  ),
  const ProfileMenuItem(icon: AppIcons.theme, title: "السمة"),
  const ProfileMenuItem(icon: AppIcons.local, title: "اللغة"),
  const ProfileMenuItem(icon: AppIcons.delete, title: "حذف الحساب"),
];
