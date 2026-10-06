import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/extensions/fake_data.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/presentation/controller/get_all_locations_cubit.dart';
import 'package:shefaa/features/location/presentation/view/add_location_screen.dart';
import 'package:shefaa/features/location/presentation/view/widget/add_location_button.dart';
import 'package:shefaa/features/location/presentation/view/widget/location_card.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';

class MyLocationsScreen extends StatelessWidget {
  const MyLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const AppText("عناويني")),
      body: BaseBlocConsumer<GetAllLocationsCubit, List<UserLocationEntity>>(
        onSuccess: (l)=>sessionCubit.updateLocations(l!),
        successBuilder: (s) => _builder(s, context),
        loadingBuilder: () =>
            _builder(UserLocationEntity.mock.fakeList(4), context),
        emptyBuilder: () => ResultView.empty(
          footer: AppButton.filled(
            "اضافة عنوان جديد",
            onTap: () => onAddLocation(context),
          ),
        ),
      ),
    );
  }

  void onAddLocation(BuildContext context) {
    final args = AddLocationScreenArgs(
      onLocationAddedSuccess: (l) {
        context.pushNamedAndRemoveUntil(
          Routes.result,
          arguments: ResultScreenArgs(
            type: ResultType.success,
            message: "تمت اضافة عنوان ${l.name ?? l.street} بنجاح ",
            footer: (c) => Column(
              children: [
                AppButton.filled(
                  "الى عناوينى",
                  onTap: () => c.pushNamed(Routes.myLocations),
                ),
                AppButton.text(
                  align: Alignment.center,
                  "الرئيسية",
                  onTap: () => c.pushNamedAndRemoveUntil(Routes.shell),
                ),
              ],
            ),
          ),
        );
      },
    );
    context.pushNamed(Routes.addLocation, arguments: args);
  }
  Widget _builder(List<UserLocationEntity> locations, BuildContext c) {
    return Column(
      spacing: UISizes.h12,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        AddLocationButton(
            isMaximum: locations.length >9,
            onTap: () => onAddLocation(c)),
        Expanded(
          child: ListView.separated(
            itemCount: locations.length,
            separatorBuilder: (c, i) => Gap.small(),
            itemBuilder: (c, i) => LocationCard(
                location: locations[i]),
          ),
        ),
      ],
    );
  }
}
