part of "../clinic_screen.dart";

class _ClinicHeader extends StatelessWidget {
  final bool isCollapsed;
  final double height;
  final ClinicEntity clinic ;

  const _ClinicHeader({required this.height, required this.clinic, required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    final bg = context.scaffoldBackgroundColor;
    final iconColor = context.colors.surfaceContainerHighest;
    final decorationHeight = height * .125;

    return SliverAppBar(
      pinned: true,
      backgroundColor: bg,
      expandedHeight: height,
      leading: AppBackButton(
        isOutlined: false,
        bgColor: bg,
        iconColor: iconColor,
      ).appPaddingAll(8),
      title: _fade(isCollapsed,  AppText(clinic.name)),
      flexibleSpace: _fade(
        !isCollapsed,
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Hero(
              tag: ValueKey(clinic.id),
              child: AppCachedNetworkImage(
                color: Colors.black26,
                colorBlendMode: BlendMode.srcATop,
                clinic.coverImage,
                height: height,
                width: context.width,
              ),
            ),
            _buildDecoration(context, decorationHeight),
            Positioned(
              bottom: decorationHeight - UISizes.h16,
              child: AppChip(
                paddingHr: UISizes.w24,
                child: AppIconText(
                  color: context.colors.onPrimary,
                  textStyle: context.textTheme.labelMedium,
                  icon: AppIcons.starFilled,
                  iconSize: UISizes.sp20,
                  text: "${clinic.rate.value} (${clinic.rate.count} تقييم)",
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppFavoriteButton(bgColor: bg, color: iconColor, favorite: clinic,),
        HGap.small(),
        AppShareButton(bgColor: bg, iconColor: iconColor, isOutlined: false),
      ],
    );
  }

  Widget _fade(bool visible, Widget child) => AnimatedScale(
    scale: visible ? 1 : 0,
    duration: 150.ms,
    child: AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: 150.ms,
      child: child,
    ),
  );
  Widget _buildDecoration(BuildContext context, double height) =>
      ClipRSuperellipse(
        borderRadius: BorderRadiusGeometry.vertical(
          top: Radius.circular(height),
        ),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: ColoredBox(color: context.scaffoldBackgroundColor),
        ),
      );
}
