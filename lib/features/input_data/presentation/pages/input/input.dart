import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/controllers/interpreter_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/injection_container.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final RC _newRC = RC();
  bool _isLoadingRCs = true;
  bool _isPredictable = false;
  List<dynamic> _existingRCs = [];

  final _formKey = GlobalKey<FormState>();
  final _rcnoController = TextEditingController(text: '');
  final _machineController = TextEditingController(text: '');
  final _materialController = TextEditingController(text: '');
  final _supplierController = TextEditingController(text: '');
  final _hardness1Controller = TextEditingController(text: '');
  final _hardness2Controller = TextEditingController(text: '');
  final _targetDimensionsController = TextEditingController(text: '');
  final _maxDimensionalAllowanceController = TextEditingController(text: '');
  final _minDimensionalAllowanceController = TextEditingController(text: '');
  final _measuredDimensionsController = TextEditingController(text: '');
  final _ambientHumidityController = TextEditingController(text: '');
  final _ambientTemperatureController = TextEditingController(text: '');
  final _feedRateController = TextEditingController(text: '');
  final _spindleSpeedRoughController = TextEditingController(text: '');
  final _spindleSpeedFineController = TextEditingController(text: '');
  final _cuttingVolumeController = TextEditingController(text: '');
  final _spindleCurrentController = TextEditingController(text: '');
  final _maxDimensionalAccuracyController = TextEditingController(text: '');
  final _minDimensionalAccuracyController = TextEditingController(text: '');
  final _surfaceRoughness1Controller = TextEditingController(text: '');
  final _surfaceRoughness2Controller = TextEditingController(text: '');
  final _surfaceRoughness3Controller = TextEditingController(text: '');
  final _roundnessController = TextEditingController(text: '');
  final _straightnessController = TextEditingController(text: '');

  Future<void> _initializeRCs() async {
    sl<FilesController>().getRCsList().then((value) {
      setState(() {
        _existingRCs = value;
        _isLoadingRCs = false;
      });
    });
  }

  void _initializeControllers() {
    _machineController.addListener(isPredictableCheck);
    _hardness1Controller.addListener(isPredictableCheck);
    _hardness2Controller.addListener(isPredictableCheck);
    _targetDimensionsController.addListener(isPredictableCheck);
    _maxDimensionalAllowanceController.addListener(isPredictableCheck);
    _minDimensionalAllowanceController.addListener(isPredictableCheck);
    _measuredDimensionsController.addListener(isPredictableCheck);
    _ambientHumidityController.addListener(isPredictableCheck);
    _ambientTemperatureController.addListener(isPredictableCheck);
  }

  double? _saveDoubleData(String data) {
    return data.isEmpty ? null : double.parse(data);
  }

  void _saveData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _newRC.rcno = _rcnoController.text.trim();
        _newRC.machine = _machineController.text.trim();
        _newRC.material = _materialController.text.trim();
        _newRC.supplier = _supplierController.text.trim();
        _newRC.hardness1 = _hardness1Controller.text.trim();
        _newRC.hardness2 = _hardness2Controller.text.trim();
        _newRC.targetDimensions = _saveDoubleData(_targetDimensionsController.text.trim());
        _newRC.maxDimensionalAllowance = _saveDoubleData(_maxDimensionalAllowanceController.text.trim());
        _newRC.minDimensionalAllowance = _saveDoubleData(_minDimensionalAllowanceController.text.trim());
        _newRC.measuredDimensions = _saveDoubleData(_measuredDimensionsController.text.trim());
        _newRC.ambientHumidity = _saveDoubleData(_ambientHumidityController.text.trim());
        _newRC.ambientTemperature = _saveDoubleData(_ambientTemperatureController.text.trim());
        _newRC.feedRate = _saveDoubleData(_feedRateController.text.trim());
        _newRC.spindleSpeedRough = _saveDoubleData(_spindleSpeedRoughController.text.trim());
        _newRC.spindleSpeedFine = _saveDoubleData(_spindleSpeedFineController.text.trim());
        _newRC.cuttingVolume = _saveDoubleData(_cuttingVolumeController.text.trim());
        _newRC.spindleCurrent = _saveDoubleData(_spindleCurrentController.text.trim());
        _newRC.maxDimensionalAccuracy = _saveDoubleData(_maxDimensionalAccuracyController.text.trim());
        _newRC.minDimensionalAccuracy = _saveDoubleData(_minDimensionalAccuracyController.text.trim());
        _newRC.surfaceRoughness1 = _saveDoubleData(_surfaceRoughness1Controller.text.trim());
        _newRC.surfaceRoughness2 = _saveDoubleData(_surfaceRoughness2Controller.text.trim());
        _newRC.surfaceRoughness3 = _saveDoubleData(_surfaceRoughness3Controller.text.trim());
        _newRC.roundness = _saveDoubleData(_roundnessController.text.trim());
        _newRC.straightness = _saveDoubleData(_straightnessController.text.trim());
      });

      sl<FilesController>().writeCsvToDirectory(_newRC).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  void isPredictableCheck() {
    final machine = _machineController.text.trim();
    final hardness1 = _hardness1Controller.text.trim();
    final hardness2 = _hardness2Controller.text.trim();
    final targetDimensions = _targetDimensionsController.text.trim();
    final maxDimensionalAllowance = _maxDimensionalAllowanceController.text.trim();
    final minDimensionalAllowance = _minDimensionalAllowanceController.text.trim();
    final measuredDimensions = _measuredDimensionsController.text.trim();
    final ambientHumidity = _ambientHumidityController.text.trim();
    final ambientTemperature = _ambientTemperatureController.text.trim();

    if (machine.isNotEmpty && hardness1.isNotEmpty && hardness2.isNotEmpty && (targetDimensions.isNotEmpty && double.tryParse(targetDimensions) != null) && (maxDimensionalAllowance.isNotEmpty && double.tryParse(maxDimensionalAllowance) != null) && (minDimensionalAllowance.isNotEmpty && double.tryParse(minDimensionalAllowance) != null) && (measuredDimensions.isNotEmpty && double.tryParse(measuredDimensions) != null) && (ambientHumidity.isNotEmpty && double.tryParse(ambientHumidity) != null) && (ambientTemperature.isNotEmpty && double.tryParse(ambientTemperature) != null)) {
      if (_isPredictable == false) {
        setState(() {
          _isPredictable = true;
        });
      }
    } else {
      if (_isPredictable == true) {
        setState(() {
          _isPredictable = false;
        });
      }
    }
  }

  @override
  void initState() {
    _initializeRCs();
    _initializeControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: _isLoadingRCs
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Padding(
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
                              required: true,
                              specialValidator: () {
                                if (_existingRCs.any((rc) => rc.rcno!.toUpperCase() == _rcnoController.text.trim().toUpperCase())) {
                                  return "這個條目已經存在";
                                }
                                return null;
                              },
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
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _feedRateController,
                              errorText: "這是必需的",
                              mainLabel: "進給量",
                              subLabel: "(m/min)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _spindleSpeedRoughController,
                              errorText: "這是必需的",
                              mainLabel: "主軸轉速(粗)",
                              subLabel: "(rpm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _spindleSpeedFineController,
                              errorText: "這是必需的",
                              mainLabel: "主軸轉速(精)",
                              subLabel: "(rpm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _cuttingVolumeController,
                              errorText: "這是必需的",
                              mainLabel: "切削量",
                              subLabel: "(mm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _spindleCurrentController,
                              errorText: "這是必需的",
                              mainLabel: "主軸電流",
                              subLabel: "(A)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _maxDimensionalAccuracyController,
                              errorText: "這是必需的",
                              mainLabel: "最大尺寸",
                              subLabel: "(mm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _minDimensionalAccuracyController,
                              errorText: "這是必需的",
                              mainLabel: "最小尺寸",
                              subLabel: "(mm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _surfaceRoughness1Controller,
                              errorText: "這是必需的",
                              mainLabel: "表粗(前)",
                              subLabel: "(μm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _surfaceRoughness2Controller,
                              errorText: "這是必需的",
                              mainLabel: "表粗(中)",
                              subLabel: "(μm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _surfaceRoughness3Controller,
                              errorText: "這是必需的",
                              mainLabel: "表粗(後)",
                              subLabel: "(μm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _roundnessController,
                              errorText: "這是必需的",
                              mainLabel: "圓度",
                              subLabel: "(mm)",
                              dataType: DataType.double,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _straightnessController,
                              errorText: "這是必需的",
                              mainLabel: "直度",
                              subLabel: "(mm)",
                              dataType: DataType.double,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      onPressed: _isPredictable ? () => sl<InterpreterController>().predict() : null,
                      textData: "AI預測",
                    ),
                    const SizedBox(height: 20),
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
