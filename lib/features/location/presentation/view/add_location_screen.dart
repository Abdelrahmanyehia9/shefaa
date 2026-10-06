import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/snack_bar.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/presentation/controller/add_location_cubit.dart';
import 'package:shefaa/features/location/presentation/view/forms/add_location_form_v2.dart';
import 'package:shefaa/features/location/presentation/view/forms/add_location_form_v3.dart';
import 'package:shefaa/shared/presentation/mixin/page_controller_mixin.dart';
import 'package:shefaa/shared/presentation/view/widgets/buttons/app_back_button.dart';

class AddLocationScreenArgs {
  final UserLocationEntity? initial;

  final VoidCallback? onSkip;

  final void Function(UserLocationEntity loc) onLocationAddedSuccess;

  const AddLocationScreenArgs({
    this.initial,
    this.onSkip,
    required this.onLocationAddedSuccess,
  });
}

class AddLocationScreen extends StatefulWidget {
  final AddLocationScreenArgs? args;

  const AddLocationScreen({super.key, this.args});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen>
    with PageControllerMixin {
  int _currentIndex = 0;
  LatLong? _coordinates;

  @override
  void initState() {
    final init = widget.args?.initial;
    if (init != null) {
      _coordinates = LatLong(lat: init.lat, long: init.long);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBodyBehindAppBar: isFirst,
      hPadding: 0,
      bottomPadding: false,
      appBar: AppBar(
        leading: AppBackButton(
          iconColor: isFirst ? Colors.white : null,
          onBack: isFirst ? null : prev,
        ).appPaddingAll(10),
        backgroundColor: isFirst ? Colors.black38 : null,
        title: Column(
          children: [
            AppText('اضافة عنوان', color: isFirst ? Colors.white : null),
            AppText(
              'خطوة ${currentIndex + 1} من $pagesLength',
              style: context.textTheme.bodyMedium,
              color: isFirst ? Colors.white70 : null,
            ),
          ],
        ),
      ),
      body: BaseBlocConsumer<AddLocationCubit, UserLocationEntity>(
        onLoading: context.loaderOverlay.show,
        onLoaded: (s) {
          context.loaderOverlay.hide();
          if (s.isFailure) {
            context.errorBar(s.error!);
          }
          if (s.isSuccess) {
            widget.args?.onLocationAddedSuccess.call(s.data!);
          }
        },
        builder: (s) => PopScope(
          canPop: isFirst,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) prev();
          },
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (i) => setState(() => _currentIndex = i),
            children: [
              AddLocationFormV2(
                initial: _coordinates,
                onSkip: widget.args?.onSkip,
                onLocationPicked: (coordinates) {
                  setState(() => _coordinates = coordinates);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) next();
                  });
                },
              ),
              if (_coordinates != null)
                AddLocationFormV3(
                  initial: widget.args?.initial,
                  onSubmit: (l) =>
                      context.read<AddLocationCubit>().addLocation(location: l),
                  key: ValueKey(_coordinates),
                  coordinates: _coordinates!,
                ).paddingAll,
            ],
          ),
        ),
      ),
    );
  }

  @override
  int get currentIndex => _currentIndex;

  @override
  int get pagesLength => 2;

  @override
  void onFinish() {
    // submit
  }
}
