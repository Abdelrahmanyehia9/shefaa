import 'package:flutter/material.dart';

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final Widget? customTrailing ;
  final void Function(BuildContext context)? onTap;

  const ProfileMenuItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.customTrailing
  });
}