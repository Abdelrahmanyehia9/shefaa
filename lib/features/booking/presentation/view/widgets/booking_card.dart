import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_switch.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_highlight.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class BookingCard extends StatelessWidget {
  final BookingStatus status;
  final Widget? footer;
  const BookingCard({
    super.key,
    this.status = BookingStatus.upcoming,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = status.isUpcoming;
    final isCancelled = status.iCancelled;

    return Card(
      elevation: UISizes.sp4,
      child: Column(
        spacing: UISizes.h8,
        children: [
          SectionHeader(
            title: FakeData.dateTime.toNameOfDayMonthYearTime(locale: "AR"),
            titleStyle: context.textTheme.labelMedium,
            paddingVr: 0,
            customAction: isUpcoming
                ? Row(
                    spacing: UISizes.sp4,
                    children: [
                      AppText("ذكرنى", style: context.textTheme.bodySmall),
                      AppSwitch(
                        value: true,
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
                null,
                width: UISizes.w80,
                height: UISizes.h96,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "دكتور خالد احمد",
                      style: context.textTheme.labelMedium,
                    ),
                    Gap.extraSmall(),
                    AppIconText(
                      icon: AppIcons.bookingLocation,
                      text: "23 شارع الحياه , حمص",
                      expandedText: true,
                      iconSize: UISizes.sp16,
                      textColor: context.colors.surfaceContainer,
                      textStyle: context.textTheme.bodyMedium,
                    ),
                    AppIconText(
                      icon: AppIcons.bookingId,
                      expandedText: true,
                      iconSize: UISizes.sp16,
                      customText: AppTextHighLight(
                        "رقم الحجز (المعرف) : *#DR452SA54*",
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
