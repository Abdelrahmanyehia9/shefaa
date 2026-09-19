import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/models/local_time.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';

class BookingInfoCard extends StatelessWidget {
  final BookingEntity booking ;
  final DateTime? dateTime ;
  final LocalTime? localTime ;
  const BookingInfoCard({super.key, this.dateTime , this.localTime, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _infoRow(title: "حالة الحجز", value: booking.status.text, context: context,customValue: AppChip(color: booking.status.color,title: booking.status.text,titleStyle: context.textTheme.titleSmall,monochromatic: true, )),
          const Divider(),
          _infoRow(title: "ميعاد الحجز", value: (dateTime??booking.time).toYearMonthDay(locale: "AR"), context: context, icon: AppIcons.calender),
          const Divider(),
          _infoRow(title: "توقيت  الحجز", value: (localTime ?? booking.localTime).formatted, context: context, icon: AppIcons.time),
        ],
      ).paddingAll,
    ) ;
  }

  Widget _infoRow({required String title, Widget? customValue, required String value ,  IconData? icon, required BuildContext context})
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconText(
          iconColor: context.colors.primary,
          text: title, icon: icon,textStyle: context.textTheme.labelLarge,),
        customValue??
        AppText(value, color: context.colors.surfaceContainer,style: context.textTheme.labelMedium,)
      ],
    );
  }
}
