import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_cached_network_image.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/domain/entity/media_entity.dart';

class GalleryGrid extends StatelessWidget {
  final bool shrinkWrap;
  final List<MediaEntity> gallery ;

  const GalleryGrid({super.key,this.gallery = const[] ,this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      itemCount: gallery.length,
      padding: EdgeInsets.zero,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: UISizes.sp8,
        mainAxisSpacing: UISizes.sp8,
      ),
      itemBuilder: (_, _) => const AppCachedNetworkImage(radius: 0, null),
    );
  }
}
