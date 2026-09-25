import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide text. Always renders in Inter.
/// Pass [style] for a full override, or the individual params to tweak
/// just those on top of the default weight/size.
class CommonText extends StatelessWidget {
  const CommonText(
    this.text, {
    super.key,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final baseStyle = GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );

    return Text(
      text,
      style: style != null ? baseStyle.merge(style) : baseStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
