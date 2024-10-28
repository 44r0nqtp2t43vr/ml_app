import 'package:flutter/cupertino.dart';

class AppBodyText extends StatelessWidget {
  final String text;

  const AppBodyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
      ),
    );
  }
}
