import 'package:flutter/cupertino.dart';

class AppTitleText extends StatelessWidget {
  final String title;

  const AppTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
