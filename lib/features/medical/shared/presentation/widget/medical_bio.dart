import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text_read_more.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/variables.dart';

class MedicalBio extends StatelessWidget {
  final String? bio ;
  const MedicalBio({super.key,this.bio });

  @override
  Widget build(BuildContext context) {
    if(bio.isNullOrEmpty) return const SizedBox.shrink( );
    return AppReadMore(
      style: context.textTheme.bodyMedium,
      maxLines: 2,
      text: bio!.trim(),
    ) ;
  }
}
