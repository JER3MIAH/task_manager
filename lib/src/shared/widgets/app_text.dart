import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final double? fontSize;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? semanticsLabel;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.fontStyle,
    this.fontFamily,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.textAlign,
    this.overflow,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          style ??
          TextStyle(
            color: color ?? Theme.of(context).colorScheme.onSurface,
            decoration: decoration,
            decorationStyle: decorationStyle,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textBaseline: textBaseline,
            height: height ?? 1.5,
            fontFamily: fontFamily,
          ),
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      textAlign: textAlign,
    );
  }
}

