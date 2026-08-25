import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategorySVG extends StatelessWidget {
  final String url;
  final double size;
  final Color color;

  const CategorySVG({
    super.key,
    required this.color,
    required this.size,
    this.url =
        "https://bdpceetislgzwpsqyfws.supabase.co/storage/v1/object/public/app_data/specialist/Union.svg",
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
