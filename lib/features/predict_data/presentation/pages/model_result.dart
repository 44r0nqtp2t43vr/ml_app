import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/interpreter_controller.dart';
import 'package:ml_app/core/widgets/app_body_text.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_title_text.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/features/predict_data/domain/model_output.dart';
import 'package:ml_app/injection_container.dart';

class ModelResult extends StatefulWidget {
  const ModelResult({super.key});

  @override
  State<ModelResult> createState() => _ModelResultState();
}

class _ModelResultState extends State<ModelResult> {
  late RC _currentRC;
  late ModelOutput _modelOutput;
  bool _isPredicting = true;

  Future<void> _predictData() async {
    sl<InterpreterController>().predict().then((value) {
      setState(() {
        _currentRC = sl<InterpreterController>().getCurrentRC()!;
        _modelOutput = sl<InterpreterController>().getCurrentModelOutput()!;
        _isPredicting = false;
      });
    });
  }

  void _replaceData(BuildContext context) {
    sl<InterpreterController>().replaceRCWithMO();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _predictData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isPredicting
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                top: 20.0,
                bottom: 40.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppTitleText(title: "現值"),
                          AppBodyText(text: "進給量=${_currentRC.feedRate != null ? _currentRC.feedRate!.toStringAsFixed(3) : 0.toStringAsFixed(3)}"),
                          AppBodyText(text: "主軸轉速(粗)=${_currentRC.spindleSpeedRough != null ? _currentRC.spindleSpeedRough!.toStringAsFixed(3) : 0.toStringAsFixed(3)}"),
                          AppBodyText(text: "主軸轉速(精)=${_currentRC.spindleSpeedFine != null ? _currentRC.spindleSpeedFine!.toStringAsFixed(3) : 0.toStringAsFixed(3)}"),
                          AppBodyText(text: "主軸電流=${_currentRC.spindleCurrent != null ? _currentRC.spindleCurrent!.toStringAsFixed(3) : 0.toStringAsFixed(3)}"),
                          const SizedBox(height: 20),
                          const AppTitleText(title: "AI預測結果"),
                          AppBodyText(text: "進給量=${_modelOutput.feedRate!.toStringAsFixed(3)}"),
                          AppBodyText(text: "主軸轉速(粗)=${_modelOutput.spindleSpeedRough != null ? _modelOutput.spindleSpeedRough!.toStringAsFixed(3) : 0.toStringAsFixed(3)}"),
                          AppBodyText(text: "主軸轉速(精)=${_modelOutput.spindleSpeedFine != null ? _modelOutput.spindleSpeedFine!.toStringAsFixed(3) : 0.toStringAsFixed(3)}"),
                          AppBodyText(text: "主軸電流=${_modelOutput.spindleCurrent!.toStringAsFixed(3)}"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    onPressed: () => _replaceData(context),
                    textData: "覆蓋現值",
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    onPressed: () => Navigator.of(context).pop(),
                    textData: "取消",
                  ),
                ],
              ),
            ),
    );
  }
}
