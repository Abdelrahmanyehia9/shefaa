import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/enum/app_permission.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/shared/presentation/view/widgets/permission_required_view.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: PermissionRequiredView(
        permission:  AppPermission.location,
        actions: (context)=>[
          AppButton.filled("السماح بالوصول"),
          AppButton.filled(
            "أدخل الموقع يدويا",
            backgroundColor: Colors.transparent,
            style: context.textTheme.labelLarge,
            textColor: context.colors.primary,
          ),
        ],
      ),
    );
  }

}
