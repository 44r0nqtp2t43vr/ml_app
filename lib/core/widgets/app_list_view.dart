import 'package:flutter/material.dart';

class AppListView extends StatelessWidget {
  final String title;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  const AppListView({
    super.key,
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
        itemCount == 0
            ? const Text(
                "空值",
                style: TextStyle(
                  fontSize: 32,
                ),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: itemBuilder,
                ),
              ),
      ],
    );
  }
}
