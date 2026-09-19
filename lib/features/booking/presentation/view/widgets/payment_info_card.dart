import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/payment_entity.dart';

class PaymentInfoCard extends StatelessWidget {
  final PaymentEntity payment;

  const PaymentInfoCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _infoRow(
            title: "حالة الدفع",
            value: payment.status.text,
            context: context,
            customValue: AppChip(
              color: payment.status.color,
              title: payment.status.text,
              titleStyle: context.textTheme.titleSmall,
              monochromatic: true,
            ),
          ),
          if(payment.transactionId!=null)...[
            const Divider(),
            _infoRow(
              title: "معرف الدفع",
              value: payment.transactionId!,
              context: context,

            ),
          ],
          const Divider(),
          _infoRow(
            title: "المبلغ",
            value: (payment.amount + payment.supportAmount).toStringAsFixed(0),
            context: context,
            icon: AppIcons.pay,
          ),
          const Divider(),
          _infoRow(
            title: "وسيلة  الدفع",
            value: payment.method.text,
            context: context,
            icon: AppIcons.wallet,
          ),



          if (payment.createdAt != null) ...[
            const Divider(),
            _infoRow(
              title: "تاريخ الدفع",
              value: payment.createdAt!.toNameOfDayMonthYearTime(locale: "AR"),
              context: context,
              icon: AppIcons.calender,
            ),
          ],

        ],
      ).paddingAll,
    );
  }

  Widget _infoRow({
    required String title,
    Widget? customValue,
    required String value,
    IconData? icon,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconText(
          iconColor: context.colors.primary,
          text: title,
          icon: icon,
          textStyle: context.textTheme.labelLarge,
        ),
        customValue ??
            AppText(
              value,
              color: context.colors.surfaceContainer,
              style: context.textTheme.labelMedium,
            ),
      ],
    );
  }
}
