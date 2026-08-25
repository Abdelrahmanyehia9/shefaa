import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/features/profile/data/models/profile_menu_item.dart';
import 'package:shefaa/features/profile/presentation/view/widgets/profile_list_tile.dart';

class ProfileMenuList extends StatelessWidget {
  final List<ProfileMenuItem> items;
  const ProfileMenuList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) =>
          Divider(color: context.colors.surfaceContainerLowest),
      itemBuilder: (context, index) {
        final item = items[index];
        return ProfileListTile(
          leading: item.icon,
          title: item.title,
          customTrailing: item.customTrailing,
          onTap: () => item.onTap?.call(context),
        );
      },
    );
  }
}
