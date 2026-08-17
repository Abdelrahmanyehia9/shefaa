import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/components/app_click.dart';

class AppReadMore extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final TextStyle? toggleStyle;
  final String readMoreText;
  final String readLessText;
  final TextAlign? textAlign;

  const AppReadMore({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.style,
    this.textAlign,
    this.toggleStyle,
    this.readMoreText = "قراء المزيد",
    this.readLessText = "قراء أقل",
  });

  @override
  State<AppReadMore> createState() => _AppReadMoreState();
}

class _AppReadMoreState extends State<AppReadMore> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final toggleStyle =
        widget.toggleStyle ??
        context.textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        );
    return LayoutBuilder(
      builder: (_, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflow = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              textAlign: widget.textAlign,
              style: widget.style,
              maxLines: _expanded ? null : widget.maxLines,
              overflow: _expanded ? null : TextOverflow.ellipsis,
            ),
            if (isOverflow)
              AppClick(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Text(
                  _expanded ? widget.readLessText : widget.readMoreText,
                  style: toggleStyle,
                ),
              ),
          ],
        );
      },
    );
  }
}
