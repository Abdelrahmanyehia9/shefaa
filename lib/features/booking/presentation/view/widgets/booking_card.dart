import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_click.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_switch.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final Widget? footer;
  const BookingCard({super.key, required this.booking, this.footer});

  @override
  Widget build(BuildContext context) {
    final isUpcoming = booking.status.isUpcoming;
    final isCancelled = booking.status.iCancelled;

    return Card(
      elevation: UISizes.sp4,
      child: Column(
        spacing: UISizes.h8,
        children: [
          SectionHeader(
            title: booking.time.toNameOfDayMonthYearTime(locale: "AR"),
            titleStyle: context.textTheme.labelMedium,
            paddingVr: 0,
            customAction: isUpcoming
                ? Row(
                    spacing: UISizes.sp4,
                    children: [
                      AppText("ذكرنى", style: context.textTheme.bodySmall),
                      AppSwitch(
                        value: booking.notificationEnabled,
                        onChanged: (_) {},
                        width: UISizes.sp28,
                        height: UISizes.sp18,
                      ),
                    ],
                  )
                : isCancelled
                ? AppIconText(
                    icon: AppIcons.error,
                    text: "السبب",
                    textStyle: context.textTheme.bodySmall,
                    color: context.colors.surfaceContainer,
                    iconSize: UISizes.sp18,
                  )
                : null,
          ),
          const Divider(),
          Row(
            spacing: UISizes.w8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCachedNetworkImage(
                booking.doctor.image,
                radius: UISizes.r14,
                width: UISizes.w80,
                height: UISizes.h96,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            "د / ${booking.doctor.name}",
                            style: context.textTheme.labelMedium,
                          ),
                        ),
                        if (booking.clinic != null)
                          Expanded(
                            child: AppClick(
                              onTap: () => context.pushNamed(
                                Routes.clinic,
                                arguments: booking.clinic,
                              ),
                              child: AppIconText(
                                icon: AppIcons.clinic,
                                expandedText: true,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                                iconSize: UISizes.sp16,
                                textStyle: context.textTheme.titleSmall,
                                color: context.colors.primary,
                                text: booking.clinic!.name,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Gap.extraSmall(),
                    AppIconText(
                      icon: AppIcons.bookingLocation,
                      text: booking.clinic?.location.name ?? "غير معروف",
                      expandedText: true,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      iconSize: UISizes.sp16,
                      textColor: context.colors.surfaceContainer,
                      textStyle: context.textTheme.bodyMedium,
                    ),
                    AppIconText(
                      icon: AppIcons.bookingId,
                      expandedText: true,
                      iconSize: UISizes.sp16,
                      customText: AppTextHighLight(
                        "رقم الحجز (المعرف) : *#${booking.id}*",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.surfaceContainer,
                        ),
                        highlighterStyle: context.textTheme.bodyMedium
                            ?.copyWith(color: context.colors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (footer != null) ...[const Divider(), footer!],
        ],
      ).paddingAll,
    );
  }
}
