import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ml_app/core/controllers/interpreter_controller.dart';
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
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      onPressed: () => _onInputButtonPressed(context),
                      textData: "新建工單",
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      onPressed: () => _onHistoryButtonPressed(context),
                      textData: "歷史資料",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  onPressed: () => _onExitButtonPressed(context),
                  textData: "離開",
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  void _onInputButtonPressed(BuildContext context) {
    sl<InterpreterController>().clearModelResults();
    Navigator.pushNamed(context, '/input');
  }

  void _onHistoryButtonPressed(BuildContext context) async {
    Navigator.pushNamed(context, '/history');
  }

  void _onExitButtonPressed(BuildContext context) {
    SystemNavigator.pop();
  }
}
