import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_read_more.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/doctor_header.dart';
import 'package:shefaa/features/explore/presentation/view/widgets/map_view.dart';
import 'package:shefaa/shared/presentation/mixin/scroll_visibility.dart';
import 'package:shefaa/shared/presentation/view/layout/reviews_list.dart';
import 'package:shefaa/shared/presentation/view/layout/sticky_bottom_layout.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/app_favorite_button.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_share_button.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/default_sticky_button.dart';

part 'widgets/doctor_bio.dart';

part 'widgets/doctor_working_hours.dart';

part 'widgets/doctor_location.dart';

part 'widgets/doctor_reviews.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with ScrollTitleVisibilityMixin {
  @override
  double get titleThreshold => UISizes.h80;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hPadding: 0,
      topPadding: false,
      body: StickyBottomLayout(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: title("د/خالد احمد"),
            backgroundColor: context.scaffoldBackgroundColor,
            centerTitle: true,
            actions: [
              const AppFavoriteButton(isOutlined: true),
              Gap.small(),
              const AppShareButton(),
            ],
          ),
        ],
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: UISizes.h12,
          children: const [
            DoctorHeader(),
            Divider(),
            _DoctorBio(),
            _DoctorWorkingHours(),
            _DoctorLocation(),
            _DoctorReviews(),
          ],
        ).paddingAll,
        sticky: DefaultStickyFooter(
          title: "حجز موعد",
          onTap: () => context.pushNamed(Routes.bookDoctor),
        ),
      ),
    );
  }
}
