part of "../clinic_screen.dart";

class _ClinicHeader extends StatelessWidget {
  final bool isCollapsed;
  final double height;

  const _ClinicHeader({required this.height, required this.isCollapsed});

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
      ).appPaddingAll(6),
      title: _fade(isCollapsed, const AppText("عيادة حياه")),
      flexibleSpace: _fade(
        !isCollapsed,
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            AppCachedNetworkImage(
              color: Colors.black26,
              colorBlendMode: BlendMode.srcATop,
              "https://wellclinics.ca/wp-content/uploads/2025/01/Gateway-Front-Entrance-scaled.jpg",
              height: height,
              width: context.width,
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
                  text: "4.3 (124 تقييم)",
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppFavoriteButton(bgColor: bg, color: iconColor),
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
