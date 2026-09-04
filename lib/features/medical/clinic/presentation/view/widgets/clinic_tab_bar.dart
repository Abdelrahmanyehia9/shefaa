import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_details_entity.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/layout/doctor_list.dart';
import 'package:shefaa/shared/presentation/view/layout/gallery_grid.dart';
import 'package:shefaa/shared/presentation/view/layout/reviews_list.dart';
import 'package:shefaa/features/medical/speciality/presentation/view/layout/speciality_categories_list.dart';

class ClinicTabBar extends StatefulWidget {
  final ClinicDetailsEntity clinic;

  const ClinicTabBar({
    super.key,
    required this.clinic,
  });

  @override
  State<ClinicTabBar> createState() => _ClinicTabBarState();
}

class _ClinicTabBarState extends State<ClinicTabBar> {
  static const tabs = ["التخصصات", "الأطباء", "المعرض", "المراجعات"];
  static const _previewLimit = 9;
  static const _backendLimit = 10;
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
            onTap: (i) => setState(() => _currentIndex = i),
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
          switch (_currentIndex) {
            0 => _specialityTabView(),
            1 => _listTab(
              items: widget.clinic.doctors,
              emptyText: "لا يوجد أطباء في هذه العيادة",
              child: (items) => DoctorList(
                shrinkWrap: true,
                doctors: items,
              ),
              buttonText: "عرض الكل",
            ),
            2 => _listTab(
              items: widget.clinic.media,
              emptyText: "لا توجد صور في هذه العيادة",
              child: (items) => GalleryGrid(
                shrinkWrap: true,
                gallery: items,
              ),
              buttonText: "عرض الكل",
            ),
            3 => _listTab(
              items: widget.clinic.reviews,
              emptyText: "لا توجد مراجعات في هذه العيادة",
              child: (items) => ReviewsList(reviews: items),
              buttonText: "عرض جميع المراجعات",
            ),
            _ => const SizedBox(),
          },
        ],
      ),
    );
  }

  Widget _specialityTabView() {
    final items = widget.clinic.specialities;
    return items.isEmpty
        ? _emptyState("لا توجد تخصصات في هذه العيادة")
        : SpecialityCategoriesList(
      axis: Axis.vertical,
      specialities: items,
      shrinkWrap: true,
    );
  }

  Widget _listTab<T>({
    required List<T> items,
    required String emptyText,
    required Widget Function(List<T>) child,
    required String buttonText,
  }) {
    if (items.isEmpty) return _emptyState(emptyText);
    return Column(
      spacing: UISizes.h12,
      children: [
        child(items.take(_previewLimit).toList()),
        if (items.length >= _backendLimit)
          AppButton.filled(buttonText),
      ],
    );
  }
  Widget _emptyState(String message) => AppText(
    message,
    style: context.textTheme.bodyMedium,
    color: context.colors.surfaceContainer,
  );
}