import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
      {super.key,
      required this.text,
      required this.style,
      this.textOverflow,
      this.maxLine});

  final String text;
  final TextStyle style;
  final TextOverflow? textOverflow;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLine ?? 1,
      overflow: textOverflow,
      softWrap: false,
      textAlign: TextAlign.left,
    );
  }
}
