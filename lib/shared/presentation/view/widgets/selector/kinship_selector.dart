import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_dropdown.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

enum Kinship {
  brotherOrSister,
  momOrDad,
  wifeOrHusband,
  sonOrDaughter,
  other;

  String get text => switch (this) {
    brotherOrSister => "اخ / اخت",
    momOrDad => "الاب / الام",
    sonOrDaughter => "الابن / الابنه",
    wifeOrHusband => "الزوج/ الزوجة",
    _ => "اخر",
  };
}

class KinshipSelector extends StatelessWidget {
  final bool isRequired;
  final Kinship? kinship  ;
  final ValueChanged<Kinship?>?onChanged ;
  const KinshipSelector({super.key, this.onChanged, this.kinship, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return AppDropdown<Kinship>(
      items: Kinship.values,
      value: kinship,
      itemLabelBuilder: (s) => s.text,
      onChange: onChanged,
      hintStyle: context.textTheme.labelSmall,
      style: context.textTheme.labelMedium,
      labelText: "صلة القرابة${isRequired ? "" : " (اختياري)"}",
      labelStyle: context.textTheme.labelMedium,
      padding: EdgeInsets.symmetric(vertical: UISizes.h6),
    );
  }
}
