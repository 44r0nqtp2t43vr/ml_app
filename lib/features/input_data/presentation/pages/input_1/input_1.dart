import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/injection_container.dart';

class Input1 extends StatefulWidget {
  const Input1({super.key});

  @override
  State<Input1> createState() => _Input1State();
}

class _Input1State extends State<Input1> {
  final RC _newRC = RC();

  final _formKey = GlobalKey<FormState>();
  final _rcnoController = TextEditingController();
  final _machineController = TextEditingController();
  final _materialController = TextEditingController();
  final _supplierController = TextEditingController();
  final _hardness1Controller = TextEditingController();
  final _hardness2Controller = TextEditingController();
  final _targetDimensionsController = TextEditingController();
  final _maxDimensionalAllowanceController = TextEditingController();
  final _minDimensionalAllowanceController = TextEditingController();
  final _measuredDimensionsController = TextEditingController();
  final _ambientHumidityController = TextEditingController();
  final _ambientTemperatureController = TextEditingController();

  void _saveData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _newRC.rcno = _rcnoController.text.trim();
        _newRC.machine = _machineController.text.trim();
        _newRC.material = _materialController.text.trim();
        _newRC.supplier = _supplierController.text.trim();
        _newRC.hardness1 = _hardness1Controller.text.trim();
        _newRC.hardness2 = _hardness2Controller.text.trim();
        _newRC.targetDimensions = double.parse(_targetDimensionsController.text.trim());
        _newRC.maxDimensionalAllowance = double.parse(_maxDimensionalAllowanceController.text.trim());
        _newRC.minDimensionalAllowance = double.parse(_minDimensionalAllowanceController.text.trim());
        _newRC.measuredDimensions = double.parse(_measuredDimensionsController.text.trim());
        _newRC.ambientHumidity = double.parse(_ambientHumidityController.text.trim());
        _newRC.ambientTemperature = double.parse(_ambientTemperatureController.text.trim());
      });

      sl<FilesController>().writeCsvToDirectory(_newRC).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 12.0,
            bottom: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      AppTextField(
                        controller: _rcnoController,
                        errorText: "這是必需的",
                        mainLabel: "批號",
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _machineController,
                        errorText: "這是必需的",
                        mainLabel: "機台",
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _materialController,
                        errorText: "這是必需的",
                        mainLabel: "材料",
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _supplierController,
                        errorText: "這是必需的",
                        mainLabel: "供應商",
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _hardness1Controller,
                        errorText: "這是必需的",
                        mainLabel: "硬度(前)",
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _hardness2Controller,
                        errorText: "這是必需的",
                        mainLabel: "硬度(後)",
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _targetDimensionsController,
                        errorText: "這是必需的",
                        mainLabel: "圖面尺寸",
                        subLabel: "(mm)",
                        dataType: DataType.double,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _maxDimensionalAllowanceController,
                        errorText: "這是必需的",
                        mainLabel: "最大尺寸預留",
                        subLabel: "(mm)",
                        dataType: DataType.double,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _minDimensionalAllowanceController,
                        errorText: "這是必需的",
                        mainLabel: "最小尺寸預留",
                        subLabel: "(mm)",
                        dataType: DataType.double,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _measuredDimensionsController,
                        errorText: "這是必需的",
                        mainLabel: "材料尺寸",
                        subLabel: "(mm)",
                        dataType: DataType.double,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _ambientHumidityController,
                        errorText: "這是必需的",
                        mainLabel: "環境濕度",
                        subLabel: "(%)",
                        dataType: DataType.double,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: _ambientTemperatureController,
                        errorText: "這是必需的",
                        mainLabel: "環境溫度",
                        subLabel: "(°C)",
                        dataType: DataType.double,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              AppButton(
                onPressed: () => _saveData(context),
                textData: "儲存",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
