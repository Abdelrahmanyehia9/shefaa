import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/features/explore/presentation/view/widgets/map_view.dart';
import 'package:shefaa/features/medical/clinic/presentation/view/layout/clinic_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/app_search_bar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(child: MapView()),
        Padding(
          padding: EdgeInsets.fromLTRB(
            UISizes.w16,
            context.safeTopArea + UISizes.h16,
            UISizes.w16,
            context.safeBottomArea + UISizes.h16,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [AppSearchBar(), ClinicList()],
          ),
        ),
      ],
    );
  }
}
