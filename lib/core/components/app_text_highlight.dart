import 'package:flutter/material.dart';

class AppTextHighLight extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? highlighterStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppTextHighLight(
    this.text, {
    super.key,
    this.style,
    this.highlighterStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  List<TextSpan> _buildSpans() {
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(r'\*(.*?)\*');
    int lastEnd = 0;

    for (final match in exp.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(text: text.substring(lastEnd, match.start), style: style),
        );
      }

      spans.add(
        TextSpan(
          text: match.group(1),
          style: (style ?? const TextStyle()).merge(highlighterStyle),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd), style: style));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(
        style: style ?? DefaultTextStyle.of(context).style,
        children: _buildSpans(),
      ),
    );
  }
}
