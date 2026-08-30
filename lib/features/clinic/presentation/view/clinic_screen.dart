import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/user_avatar.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/clinic/presentation/view/widgets/clinic_tab_bar.dart';
import 'package:shefaa/shared/presentation/mixin/scroll_visibility.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_back_button.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/app_favorite_button.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_share_button.dart';
part 'widgets/clinic_header.dart';
part 'layout/clinic_layout.dart';
part 'widgets/clinic_name_and_specialities.dart';
part 'widgets/clinic_states.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      topPadding: false,
      hPadding: 0,
      vPadding: 0,
      body: _ClinicLayout(
        header: (isCollapsed, height) =>
            _ClinicHeader(height: height, isCollapsed: isCollapsed),
        body: Column(
          spacing: UISizes.h12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _ClinicNameAndSpecialities(),
            VGap(8),

            _ClinicStates(),
            ClinicTabBar(),
          ],
        ).paddingHr,
      ),
    );
  }
}
