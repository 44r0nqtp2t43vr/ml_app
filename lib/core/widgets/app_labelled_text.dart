import 'package:flutter/material.dart';

class AppLabelledText extends StatelessWidget {
  final String label;
  final String? text;

  const AppLabelledText({
    super.key,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    const double fontSize = 32;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: double.infinity),
        Text(
          label,
          style: const TextStyle(
            fontSize: fontSize,
          ),
        ),
        Text(
          text == null ? "空值" : text!,
          style: const TextStyle(
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
