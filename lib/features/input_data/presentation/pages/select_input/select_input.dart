import 'package:flutter/material.dart';
import 'package:ml_app/core/widgets/app_button.dart';

class SelectInput extends StatelessWidget {
  const SelectInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              onPressed: () => _onButtonOnePressed(),
              textData: "1. 新建工單",
            ),
            const SizedBox(height: 40),
            AppButton(
              onPressed: () => _onButtonTwoPressed(),
              textData: "2. 加工中",
            ),
            const SizedBox(height: 40),
            AppButton(
              onPressed: () => _onButtonThreePressed(),
              textData: "3. 成品量測",
            ),
            const SizedBox(height: 40),
            AppButton(
              onPressed: () => _onHistoryButtonPressed(),
              textData: "歷史資料",
            ),
            const SizedBox(height: 40),
            AppButton(
              onPressed: () => _onExitButtonPressed(),
              textData: "離開",
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonOnePressed() {}

  void _onButtonTwoPressed() {}

  void _onButtonThreePressed() {}

  void _onHistoryButtonPressed() {}

  void _onExitButtonPressed() {}
}
