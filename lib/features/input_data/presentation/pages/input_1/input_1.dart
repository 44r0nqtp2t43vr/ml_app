import 'package:flutter/material.dart';
import 'package:ml_app/core/resources/formatters.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';

class Input1 extends StatefulWidget {
  const Input1({super.key});

  @override
  State<Input1> createState() => _Input1State();
}

class _Input1State extends State<Input1> {
  final RC _newRC = RC();
  int _pageInd = 0;

  final _formKey = GlobalKey<FormState>();
  final _rcnoController = TextEditingController();
  final _materialController = TextEditingController();
  final _supplierController = TextEditingController();
  final _hardnessController = TextEditingController();
  final _targetDimensionsController = TextEditingController();
  final _tolerancePrecisionController = TextEditingController();
  final _measuredDimensionsController = TextEditingController();
  final _dimensionalAllowanceController = TextEditingController();
  final _ambientHumidityController = TextEditingController();
  final _ambientTemperatureController = TextEditingController();

  void _nextPage() {
    setState(() {
      if (_pageInd >= 0 && _pageInd <= 3) {
        _pageInd++;
      }
    });
  }

  void _saveData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _newRC.rcno = _rcnoController.text.trim();
        _newRC.date = dateTimeToString(DateTime.now());
        _newRC.material = _materialController.text.trim();
        _newRC.supplier = _supplierController.text.trim();
        _newRC.hardness = _hardnessController.text.trim();
        _newRC.targetDimensions = double.parse(_targetDimensionsController.text.trim());
        _newRC.tolerancePrecision = double.parse(_tolerancePrecisionController.text.trim());
        _newRC.measuredDimensions = double.parse(_measuredDimensionsController.text.trim());
        _newRC.dimensionalAllowance = double.parse(_dimensionalAllowanceController.text.trim());
        _newRC.ambientHumidity = double.parse(_ambientHumidityController.text.trim());
        _newRC.ambientTemperature = double.parse(_ambientTemperatureController.text.trim());

        print(_newRC.toMap());
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: _getBody(context),
        ),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    switch (_pageInd) {
      case 0:
        return _input1Page1();
      case 1:
        return _input1Page2();
      case 2:
        return _input1Page3();
      case 3:
        return _input1Page4();
      case 4:
        return _verificationPage(context);
      default:
        return _input1Page1();
    }
  }

  Widget _input1Page1() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 12.0,
            bottom: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTextField(
                controller: _rcnoController,
                errorText: "這是必需的",
                mainLabel: "批號",
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
              const SizedBox(height: 60),
              AppButton(
                onPressed: () => _nextPage(),
                textData: "下一頁",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input1Page2() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
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
              AppTextField(
                controller: _hardnessController,
                errorText: "這是必需的",
                mainLabel: "硬度",
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
                controller: _tolerancePrecisionController,
                errorText: "這是必需的",
                mainLabel: "圖面公差",
                subLabel: "(mm)",
                dataType: DataType.double,
              ),
              const SizedBox(height: 60),
              AppButton(
                onPressed: () => _nextPage(),
                textData: "下一頁",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input1Page3() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
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
              AppTextField(
                controller: _measuredDimensionsController,
                errorText: "這是必需的",
                mainLabel: "材料尺寸",
                subLabel: "(mm)",
                dataType: DataType.double,
              ),
              const SizedBox(height: 40),
              AppTextField(
                controller: _dimensionalAllowanceController,
                errorText: "這是必需的",
                mainLabel: "尺寸預留量",
                subLabel: "(mm)",
                dataType: DataType.double,
              ),
              const SizedBox(height: 60),
              AppButton(
                onPressed: () => _nextPage(),
                textData: "下一頁",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input1Page4() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
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
              const SizedBox(height: 60),
              AppButton(
                onPressed: () => _nextPage(),
                textData: "下一頁",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verificationPage(BuildContext context) {
    return Padding(
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
                    controller: _hardnessController,
                    errorText: "這是必需的",
                    mainLabel: "硬度",
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
                    controller: _tolerancePrecisionController,
                    errorText: "這是必需的",
                    mainLabel: "圖面公差",
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
                    controller: _dimensionalAllowanceController,
                    errorText: "這是必需的",
                    mainLabel: "尺寸預留量",
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
    );
  }
}
