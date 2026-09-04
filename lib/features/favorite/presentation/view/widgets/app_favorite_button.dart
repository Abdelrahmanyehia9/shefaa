import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/components/overlay/popups.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/medical.dart';
import 'package:shefaa/core/utils/app_colors.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:shefaa/features/favorite/presentation/mixin/favorite_animation_mixin.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/remove_favorite_confirm_popup.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';
import 'package:shefaa/features/favorite/presentation/view/widgets/favorite_builder.dart';

class AppFavoriteButton extends StatefulWidget {
  const AppFavoriteButton({
    super.key,
    this.isOutlined = false,
    this.size,
    this.color,
    this.bgColor,
    this.favorite,
  });

  final Color? color;
  final Color? bgColor;
  final double? size;
  final bool isOutlined;
  final Medical? favorite;

  @override
  State<AppFavoriteButton> createState() => _AppFavoriteButtonState();
}

class _AppFavoriteButtonState extends State<AppFavoriteButton>
    with SingleTickerProviderStateMixin, FavoriteAnimationMixin {
  Future<void> _onTap({Medical? favorite, required bool isFavorite}) async {
    if (favorite == null) return;
    final cubit = context.read<FavoriteCubit>();
    if (isFavorite && cubit.showConfirmAlert) {
      final confirm = await Popups.show<bool>(
        child: RemoveFavoriteConfirmPopup(favorite: favorite),
      );
      if (confirm != true) return;
    }
    playFavoriteAnimation();
    cubit.toggleFavorite(favorite);
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = widget.size ?? UISizes.sp24;
    final padding = UISizes.sp6;
    final boxSize = iconSize + padding * 2;
    return FavoriteBuilder(
      favorite: widget.favorite,
      builder: (cubit, favorite, isFavorite) {
        return AnimatedBuilder(
          animation: favoriteAnimController,
          builder: (context, _) {
            return SizedBox(
              width: boxSize,
              height: boxSize,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Transform.scale(
                    scale: favoriteScaleAnim.value,
                    child: _buildButton(
                      context,
                      isFavorite: isFavorite,
                      padding: padding,
                      iconSize: iconSize,
                      onTap: () => _onTap(
                        favorite: widget.favorite,
                        isFavorite: isFavorite,
                      ),
                    ),
                  ),
                  if (favoriteAnimController.isAnimating && isFavorite)
                    ...buildParticles(
                      iconSize: iconSize,
                      padding: padding,
                      icon: AppIcons.favorite,
                      colors: AppColors.mainColors,
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required bool isFavorite,
    required double padding,
    required double iconSize,
    VoidCallback? onTap,
  }) {
    final icon = isFavorite ? AppIcons.favoriteFiled : AppIcons.favorite;
    if (widget.isOutlined) {
      return CircleIconButton.outLine(icon, context: context, onTap: onTap,
      customIcon: Icon(icon, color: isFavorite ? context.colors.error : null,),
      );
    }
    final iconColor = isFavorite
        ? context.colors.error
        : widget.color ?? context.colors.surfaceContainer;
    return CircleIconButton(
      icon,
      backgroundColor: widget.bgColor ?? AppColors.white.softLight,
      padding: padding,
      iconColor: iconColor,
      iconSize: iconSize,
      onTap: onTap,
    );
  }
}
