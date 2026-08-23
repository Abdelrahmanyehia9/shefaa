import 'package:flutter/material.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/widgets/clinic_card.dart';

class ClinicList extends StatelessWidget {
  final bool shrinkWrap  ;
  final Axis axis ;
  const ClinicList({super.key, this.axis = Axis.horizontal, this.shrinkWrap = false });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height:axis.isVertical ? null :  ClinicCard.cardSize.height,
      child: ListView.separated(
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          shrinkWrap: shrinkWrap,
          scrollDirection: axis,
          physics: shrinkWrap? const NeverScrollableScrollPhysics() : null,
          itemBuilder: (_,i)=>const ClinicCard(),
          separatorBuilder: (_,_)=>Gap(axis: axis,UISizes.sp8),
          itemCount: 4
      ),
    ) ;
  }
}
