import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_checkbox.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/favorite.dart';
import 'package:shefaa/features/favorite/presentation/controller/favorite_cubit.dart';

class RemoveFavoriteConfirmPopup extends StatefulWidget {
  final Favorite favorite;

  const RemoveFavoriteConfirmPopup({super.key, required this.favorite});

  @override
  State<RemoveFavoriteConfirmPopup> createState() =>
      _RemoveFavoriteConfirmPopupState();
}

class _RemoveFavoriteConfirmPopupState
    extends State<RemoveFavoriteConfirmPopup> {
  final ValueNotifier<bool> showThisAgain = ValueNotifier(false);

  void toggleShowAgain(bool i) {
    showThisAgain.value = i;
    context.read<FavoriteCubit>().showConfirmAlert = !i;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: UISizes.h8,
      children: [
        Gap.small(),
        AppText(
          "هل انت متاكد من حذف من المفضلة ؟",
          style: context.textTheme.titleLarge,
        ),
        Gap.small(),
        AbsorbPointer(
          child: SizedBox(width: double.infinity, child: widget.favorite.card())
              .animate()
              .shimmer(
                duration: 500.ms,
                delay: 300.ms,
                color: context.scaffoldBackgroundColor,
              ),
        ),
        Gap.small(),
        ValueListenableBuilder(
          valueListenable: showThisAgain,
          builder: (context, value, child) {
            return Row(
              spacing: UISizes.w8,
              children: [
                AppCheckbox(
                  borderColor: Colors.transparent,
                  value: value,
                  onChanged: toggleShowAgain,
                ),
                child!,
              ],
            );
          },
          child: AppText(
            "لاتظهر ذلك مجددا",
            style: context.textTheme.labelMedium,
          ),
        ),
        Row(
          spacing: UISizes.sp4,
          children: [
            Expanded(
              child: AppButton.filled("تاكيد", onTap: () => context.pop(true)),
            ),
            Expanded(
              child: AppButton.outlined(
                "الغاء",
                onTap: () => context.pop(false),
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    showThisAgain.dispose();
    super.dispose();
  }
}
