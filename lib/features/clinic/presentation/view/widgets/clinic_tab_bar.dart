import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/shared/presentation/view/layout/gallery_grid.dart';
import 'package:shefaa/shared/presentation/view/layout/reviews_list.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_categories_list.dart';

class ClinicTabBar extends StatefulWidget {
  const ClinicTabBar({super.key});

  @override
  State<ClinicTabBar> createState() => _ClinicTabBarState();
}

class _ClinicTabBarState extends State<ClinicTabBar> {
  static const tabs = ["التخصصات", "الأطباء", "المعرض", "المراجعات"];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        spacing: UISizes.h16,
        children: [
          TabBar(
            unselectedLabelStyle: context.textTheme.labelMedium,
            labelStyle: context.textTheme.labelMedium,
            onTap: (index) => setState(() => _currentIndex = index),
            tabs: tabs.map((text) => Tab(text: text)).toList(),
          ),
          switch (_currentIndex) {
            0 => const SpecialityCategoriesList(
              axis: Axis.vertical,
              shrinkWrap: true,
            ),
            1 => _doctorTabView(),
            2 => _galleryTapView(),
            3 => _reviewsTabView(),
            _ => const SizedBox(),
          },
        ],
      ),
    );
  }

  Widget _doctorTabView() => Column(
    spacing: UISizes.h12,
    children: [
      const DoctorList(shrinkWrap: true),
      AppButton.filled("عرض الكل"),
    ],
  );
  Widget _galleryTapView() => Column(
    spacing: UISizes.h12,
    children: [
      const GalleryGrid(shrinkWrap: true),
      AppButton.filled("عرض الكل"),
    ],
  );
  Widget _reviewsTabView() => Column(
    spacing: UISizes.h12,
    children: [const ReviewsList(), AppButton.filled("عرض جميع المراجعات")],
  );
}
