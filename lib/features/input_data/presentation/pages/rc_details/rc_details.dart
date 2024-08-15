import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_labelled_text.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/injection_container.dart';

class RCDetails extends StatefulWidget {
  final RC selectedRC;

  const RCDetails({super.key, required this.selectedRC});

  @override
  State<RCDetails> createState() => _RCDetailsState();
}

class _RCDetailsState extends State<RCDetails> {
  late RC _selectedRC;
  late String _oldRcno;
  bool _isLoadingRCs = true;
  List<dynamic> _existingRCs = [];

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
  final _feedRateController = TextEditingController();
  final _spindleSpeedRoughController = TextEditingController();
  final _spindleSpeedFineController = TextEditingController();
  final _cuttingVolumeController = TextEditingController();
  final _spindleCurrentController = TextEditingController();
  final _maxDimensionalAccuracyController = TextEditingController();
  final _minDimensionalAccuracyController = TextEditingController();
  final _surfaceRoughness1Controller = TextEditingController();
  final _surfaceRoughness2Controller = TextEditingController();
  final _surfaceRoughness3Controller = TextEditingController();
  final _roundnessController = TextEditingController();
  final _straightnessController = TextEditingController();

  Future<void> _initializeRCs() async {
    sl<FilesController>().getRCsList().then((value) {
      setState(() {
        _existingRCs = value;
        _isLoadingRCs = false;
      });
    });
  }

  void _saveData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _selectedRC.rcno = _rcnoController.text.trim();
        _selectedRC.machine = _machineController.text.trim();
        _selectedRC.material = _materialController.text.trim();
        _selectedRC.supplier = _supplierController.text.trim();
        _selectedRC.hardness1 = _hardness1Controller.text.trim();
        _selectedRC.hardness2 = _hardness2Controller.text.trim();
        _selectedRC.targetDimensions = double.parse(_targetDimensionsController.text.trim());
        _selectedRC.maxDimensionalAllowance = double.parse(_maxDimensionalAllowanceController.text.trim());
        _selectedRC.minDimensionalAllowance = double.parse(_minDimensionalAllowanceController.text.trim());
        _selectedRC.measuredDimensions = double.parse(_measuredDimensionsController.text.trim());
        _selectedRC.ambientHumidity = double.parse(_ambientHumidityController.text.trim());
        _selectedRC.ambientTemperature = double.parse(_ambientTemperatureController.text.trim());
        _selectedRC.feedRate = double.parse(_feedRateController.text.trim());
        _selectedRC.spindleSpeedRough = double.parse(_spindleSpeedRoughController.text.trim());
        _selectedRC.spindleSpeedFine = double.parse(_spindleSpeedFineController.text.trim());
        _selectedRC.cuttingVolume = double.parse(_cuttingVolumeController.text.trim());
        _selectedRC.spindleCurrent = double.parse(_spindleCurrentController.text.trim());
        _selectedRC.maxDimensionalAccuracy = double.parse(_maxDimensionalAccuracyController.text.trim());
        _selectedRC.minDimensionalAccuracy = double.parse(_minDimensionalAccuracyController.text.trim());
        _selectedRC.surfaceRoughness1 = double.parse(_surfaceRoughness1Controller.text.trim());
        _selectedRC.surfaceRoughness2 = double.parse(_surfaceRoughness2Controller.text.trim());
        _selectedRC.surfaceRoughness3 = double.parse(_surfaceRoughness3Controller.text.trim());
        _selectedRC.roundness = double.parse(_roundnessController.text.trim());
        _selectedRC.straightness = double.parse(_straightnessController.text.trim());
      });

      sl<FilesController>().writeCsvToDirectory(_selectedRC, oldRcno: _oldRcno).then((value) {
        Navigator.of(context).pop(true);
      });
    }
  }

  @override
  void initState() {
    _selectedRC = widget.selectedRC;
    _oldRcno = widget.selectedRC.rcno.toString();
    _rcnoController.text = widget.selectedRC.rcno.toString();
    _machineController.text = widget.selectedRC.machine.toString();
    _materialController.text = widget.selectedRC.material.toString();
    _supplierController.text = widget.selectedRC.supplier.toString();
    _hardness1Controller.text = widget.selectedRC.hardness1.toString();
    _hardness2Controller.text = widget.selectedRC.hardness2.toString();
    _targetDimensionsController.text = widget.selectedRC.targetDimensions.toString();
    _maxDimensionalAllowanceController.text = widget.selectedRC.maxDimensionalAllowance.toString();
    _minDimensionalAllowanceController.text = widget.selectedRC.minDimensionalAllowance.toString();
    _measuredDimensionsController.text = widget.selectedRC.measuredDimensions.toString();
    _ambientHumidityController.text = widget.selectedRC.ambientHumidity.toString();
    _ambientTemperatureController.text = widget.selectedRC.ambientTemperature.toString();
    _feedRateController.text = widget.selectedRC.feedRate.toString();
    _spindleSpeedRoughController.text = widget.selectedRC.spindleSpeedRough.toString();
    _spindleSpeedFineController.text = widget.selectedRC.spindleSpeedFine.toString();
    _cuttingVolumeController.text = widget.selectedRC.cuttingVolume.toString();
    _spindleCurrentController.text = widget.selectedRC.spindleCurrent.toString();
    _maxDimensionalAccuracyController.text = widget.selectedRC.maxDimensionalAccuracy.toString();
    _minDimensionalAccuracyController.text = widget.selectedRC.minDimensionalAccuracy.toString();
    _surfaceRoughness1Controller.text = widget.selectedRC.surfaceRoughness1.toString();
    _surfaceRoughness2Controller.text = widget.selectedRC.surfaceRoughness2.toString();
    _surfaceRoughness3Controller.text = widget.selectedRC.surfaceRoughness3.toString();
    _roundnessController.text = widget.selectedRC.roundness.toString();
    _straightnessController.text = widget.selectedRC.straightness.toString();

    _initializeRCs();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            AppLabelledText(
                              label: "日期",
                              text: widget.selectedRC.date,
                            ),
                            const SizedBox(height: 40),
                            AppTextField(
                              controller: _rcnoController,
                              errorText: "這是必需的",
                              mainLabel: "批號",
                              specialValidator: () {
                                if (_existingRCs.any((rc) => rc.rcno != _oldRcno && rc.rcno!.toUpperCase() == _rcnoController.text.trim().toUpperCase())) {
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
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      onPressed: () => _saveData(context),
                      textData: "更新",
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
