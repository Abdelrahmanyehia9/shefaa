import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/overlay/bottom_sheets.dart';
import 'package:shefaa/core/enum/app_permission.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/permission_handler.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/controllers/permission_cubit.dart';

class PermissionConsumer extends StatelessWidget {
  final Widget? grantedBuilder;
  final Widget? deniedBuilder;
  final VoidCallback? onGranted;
  final AppPermission permission;
  final VoidCallback? onDenied;
  final VoidCallback? appSettings;
  final Widget Function(BuildContext, PermissionResult)? builder;

  const PermissionConsumer({
    super.key,
    required this.permission,
    this.grantedBuilder,
    this.deniedBuilder,
    this.onGranted,
    this.onDenied,
    this.appSettings,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionCubit, PermissionState>(
      listener: (c, state) {
        final result = state.result;

        if (result.isGranted) {
          onGranted?.call();
          return;
        }

        if (result.isDenied) {
          onDenied?.call();
          return;
        }

        if (result.isPermanentlyDenied) {
          _showSettingsBottomSheet(context, );
        }
      },
      builder: (c, state) {
        final result = state.result;

        final fallback =
            builder?.call(context, result) ?? const SizedBox.shrink();

        if (result.isGranted) {
          return grantedBuilder ?? fallback;
        }

        if (result.isDenied ||
            result.isPermanentlyDenied ||
            result.isRestricted) {
          return deniedBuilder ?? fallback;
        }

        return fallback;
      },
    );
  }

  void _showSettingsBottomSheet(
      BuildContext context,
      ) {
    final cubit = context.read<PermissionCubit>() ;
    BottomSheets.show(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppChip(
            shape: BoxShape.circle,
            paddingVr: UISizes.sp24,
            paddingHr: UISizes.sp24,
            monochromatic: true,
            child: Icon(
              permission.icon,
              size: UISizes.sp48,
              color: context.colors.primary,
            ),
          ),
          Gap.small(),
          AppText(
            "السماح بالوصول إلى ${permission.text}",
            style: context.textTheme.titleMedium,
          ),
          AppText(
            permission.reason,
            style: context.textTheme.labelMedium,
            color: context.colors.surfaceContainer,
          ),
          Gap.small(),
          Row(
            spacing: UISizes.w8,
            children: [
              Expanded(
                child: AppButton.filled(
                  "الإعدادات",
                  onTap: () {
                    if (appSettings != null) {
                      appSettings!.call();
                    } else {
                      cubit.openSettings();
                    }
                  },
                ),
              ),
              Expanded(
                child: AppButton.outlined(
                  "إلغاء",
                  onTap: context.pop,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}