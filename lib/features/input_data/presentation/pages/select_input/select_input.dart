import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/injection_container.dart';

class SelectInput extends StatelessWidget {
  const SelectInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                onPressed: () => _onButtonOnePressed(context),
                textData: "1. 新建工單",
              ),
              const SizedBox(height: 40),
              AppButton(
                onPressed: () => _onButtonTwoPressed(context),
                textData: "2. 加工中",
              ),
              const SizedBox(height: 40),
              AppButton(
                onPressed: () => _onButtonThreePressed(context),
                textData: "3. 成品量測",
              ),
              const SizedBox(height: 40),
              AppButton(
                onPressed: () => _onHistoryButtonPressed(context),
                textData: "歷史資料",
              ),
              const SizedBox(height: 40),
              AppButton(
                onPressed: () => _onExitButtonPressed(context),
                textData: "離開",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonOnePressed(BuildContext context) {
    Navigator.pushNamed(context, '/input1');
  }

  void _onButtonTwoPressed(BuildContext context) {
    Navigator.pushNamed(context, '/input2');
  }

  void _onButtonThreePressed(BuildContext context) {
    Navigator.pushNamed(context, '/input3');
  }

  void _onHistoryButtonPressed(BuildContext context) async {
    await sl<FilesController>().writeCsvToDirectory();
    await sl<FilesController>().readCsvFromDirectory();
    // Navigator.pushNamed(context, '/history');
  }

  void _onExitButtonPressed(BuildContext context) {
    SystemNavigator.pop();
  }
}
