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
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(url);

    final isValidUrl =
        uri != null &&
        uri.hasScheme &&
        uri.hasAuthority &&
        (uri.scheme == 'http' || uri.scheme == 'https');

    if (!isValidUrl) {
      return SizedBox.square(dimension: size);
    }

    return SvgPicture.network(
      url,
      width: size,
      height: size,
      errorBuilder: (_, _, _) => SizedBox.square(dimension: size),
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
