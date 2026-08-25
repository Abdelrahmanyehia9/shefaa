import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/shared/presentation/view/layout/speciality_categories_list.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_search_button.dart';

class SpecialityCategoriesScreen extends StatelessWidget {
  const SpecialityCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText("التخصصات"),
        actions: const [AppSearchButton()],
      ),
      body: const SpecialityCategoriesList(axis: Axis.vertical),
    );
  }
}
