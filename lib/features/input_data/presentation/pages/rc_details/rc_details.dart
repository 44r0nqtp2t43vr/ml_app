import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/controllers/interpreter_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_labelled_text.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/features/predict_data/domain/model_input.dart';
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
  bool _isPredictable = false;
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

  double? _saveDoubleData(String data) {
    return data.isEmpty ? null : double.parse(data);
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
        _selectedRC.targetDimensions = _saveDoubleData(_targetDimensionsController.text.trim());
        _selectedRC.maxDimensionalAllowance = _saveDoubleData(_maxDimensionalAllowanceController.text.trim());
        _selectedRC.minDimensionalAllowance = _saveDoubleData(_minDimensionalAllowanceController.text.trim());
        _selectedRC.measuredDimensions = _saveDoubleData(_measuredDimensionsController.text.trim());
        _selectedRC.ambientHumidity = _saveDoubleData(_ambientHumidityController.text.trim());
        _selectedRC.ambientTemperature = _saveDoubleData(_ambientTemperatureController.text.trim());
        _selectedRC.feedRate = _saveDoubleData(_feedRateController.text.trim());
        _selectedRC.spindleSpeedRough = _saveDoubleData(_spindleSpeedRoughController.text.trim());
        _selectedRC.spindleSpeedFine = _saveDoubleData(_spindleSpeedFineController.text.trim());
        _selectedRC.cuttingVolume = _saveDoubleData(_cuttingVolumeController.text.trim());
        _selectedRC.spindleCurrent = _saveDoubleData(_spindleCurrentController.text.trim());
        _selectedRC.maxDimensionalAccuracy = _saveDoubleData(_maxDimensionalAccuracyController.text.trim());
        _selectedRC.minDimensionalAccuracy = _saveDoubleData(_minDimensionalAccuracyController.text.trim());
        _selectedRC.surfaceRoughness1 = _saveDoubleData(_surfaceRoughness1Controller.text.trim());
        _selectedRC.surfaceRoughness2 = _saveDoubleData(_surfaceRoughness2Controller.text.trim());
        _selectedRC.surfaceRoughness3 = _saveDoubleData(_surfaceRoughness3Controller.text.trim());
        _selectedRC.roundness = _saveDoubleData(_roundnessController.text.trim());
        _selectedRC.straightness = _saveDoubleData(_straightnessController.text.trim());
      });

      sl<FilesController>().writeCsvToDirectory(_selectedRC, oldRcno: _oldRcno).then((value) {
        Navigator.of(context).pop(true);
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

  String _initializeTextController(dynamic property) {
    return property == null ? '' : property.toString();
  }

  void _initializeControllers() {
    RC? basisRC = sl<InterpreterController>().currentRC;
    basisRC ??= widget.selectedRC;

    _machineController.addListener(isPredictableCheck);
    _hardness1Controller.addListener(isPredictableCheck);
    _hardness2Controller.addListener(isPredictableCheck);
    _targetDimensionsController.addListener(isPredictableCheck);
    _maxDimensionalAllowanceController.addListener(isPredictableCheck);
    _minDimensionalAllowanceController.addListener(isPredictableCheck);
    _measuredDimensionsController.addListener(isPredictableCheck);
    _ambientHumidityController.addListener(isPredictableCheck);
    _ambientTemperatureController.addListener(isPredictableCheck);

    _rcnoController.text = _initializeTextController(basisRC.rcno);
    _machineController.text = _initializeTextController(basisRC.machine);
    _materialController.text = _initializeTextController(basisRC.material);
    _supplierController.text = _initializeTextController(basisRC.supplier);
    _hardness1Controller.text = _initializeTextController(basisRC.hardness1);
    _hardness2Controller.text = _initializeTextController(basisRC.hardness2);
    _targetDimensionsController.text = _initializeTextController(basisRC.targetDimensions);
    _maxDimensionalAllowanceController.text = _initializeTextController(basisRC.maxDimensionalAllowance);
    _minDimensionalAllowanceController.text = _initializeTextController(basisRC.minDimensionalAllowance);
    _measuredDimensionsController.text = _initializeTextController(basisRC.measuredDimensions);
    _ambientHumidityController.text = _initializeTextController(basisRC.ambientHumidity);
    _ambientTemperatureController.text = _initializeTextController(basisRC.ambientTemperature);
    _feedRateController.text = _initializeTextController(basisRC.feedRate);
    _spindleSpeedRoughController.text = _initializeTextController(basisRC.spindleSpeedRough);
    _spindleSpeedFineController.text = _initializeTextController(basisRC.spindleSpeedFine);
    _cuttingVolumeController.text = _initializeTextController(basisRC.cuttingVolume);
    _spindleCurrentController.text = _initializeTextController(basisRC.spindleCurrent);
    _maxDimensionalAccuracyController.text = _initializeTextController(basisRC.maxDimensionalAccuracy);
    _minDimensionalAccuracyController.text = _initializeTextController(basisRC.minDimensionalAccuracy);
    _surfaceRoughness1Controller.text = _initializeTextController(basisRC.surfaceRoughness1);
    _surfaceRoughness2Controller.text = _initializeTextController(basisRC.surfaceRoughness2);
    _surfaceRoughness3Controller.text = _initializeTextController(basisRC.surfaceRoughness3);
    _roundnessController.text = _initializeTextController(basisRC.roundness);
    _straightnessController.text = _initializeTextController(basisRC.straightness);
  }

  void _predictData(BuildContext context) {
    final currentRC = RC(
      rcno: _rcnoController.text.trim(),
      machine: _machineController.text.trim(),
      material: _materialController.text.trim(),
      supplier: _supplierController.text.trim(),
      hardness1: _hardness1Controller.text.trim(),
      hardness2: _hardness2Controller.text.trim(),
      targetDimensions: double.tryParse(_targetDimensionsController.text.trim()) == null ? null : _saveDoubleData(_targetDimensionsController.text.trim()),
      maxDimensionalAllowance: double.tryParse(_maxDimensionalAllowanceController.text.trim()) == null ? null : _saveDoubleData(_maxDimensionalAllowanceController.text.trim()),
      minDimensionalAllowance: double.tryParse(_minDimensionalAllowanceController.text.trim()) == null ? null : _saveDoubleData(_minDimensionalAllowanceController.text.trim()),
      measuredDimensions: double.tryParse(_measuredDimensionsController.text.trim()) == null ? null : _saveDoubleData(_measuredDimensionsController.text.trim()),
      ambientHumidity: double.tryParse(_ambientHumidityController.text.trim()) == null ? null : _saveDoubleData(_ambientHumidityController.text.trim()),
      ambientTemperature: double.tryParse(_ambientTemperatureController.text.trim()) == null ? null : _saveDoubleData(_ambientTemperatureController.text.trim()),
      feedRate: double.tryParse(_feedRateController.text.trim()) == null ? null : _saveDoubleData(_feedRateController.text.trim()),
      spindleSpeedRough: double.tryParse(_spindleSpeedRoughController.text.trim()) == null ? null : _saveDoubleData(_spindleSpeedRoughController.text.trim()),
      spindleSpeedFine: double.tryParse(_spindleSpeedFineController.text.trim()) == null ? null : _saveDoubleData(_spindleSpeedFineController.text.trim()),
      cuttingVolume: double.tryParse(_cuttingVolumeController.text.trim()) == null ? null : _saveDoubleData(_cuttingVolumeController.text.trim()),
      spindleCurrent: double.tryParse(_spindleCurrentController.text.trim()) == null ? null : _saveDoubleData(_spindleCurrentController.text.trim()),
      maxDimensionalAccuracy: double.tryParse(_maxDimensionalAccuracyController.text.trim()) == null ? null : _saveDoubleData(_maxDimensionalAccuracyController.text.trim()),
      minDimensionalAccuracy: double.tryParse(_minDimensionalAccuracyController.text.trim()) == null ? null : _saveDoubleData(_minDimensionalAccuracyController.text.trim()),
      surfaceRoughness1: double.tryParse(_surfaceRoughness1Controller.text.trim()) == null ? null : _saveDoubleData(_surfaceRoughness1Controller.text.trim()),
      surfaceRoughness2: double.tryParse(_surfaceRoughness2Controller.text.trim()) == null ? null : _saveDoubleData(_surfaceRoughness2Controller.text.trim()),
      surfaceRoughness3: double.tryParse(_surfaceRoughness3Controller.text.trim()) == null ? null : _saveDoubleData(_surfaceRoughness3Controller.text.trim()),
      roundness: double.tryParse(_roundnessController.text.trim()) == null ? null : _saveDoubleData(_roundnessController.text.trim()),
      straightness: double.tryParse(_straightnessController.text.trim()) == null ? null : _saveDoubleData(_straightnessController.text.trim()),
    );

    final modelInput = ModelInput(
      machine: currentRC.machine,
      hardness1: currentRC.hardness1,
      hardness2: currentRC.hardness2,
      targetDimensions: currentRC.targetDimensions,
      maxDimensionalAllowance: currentRC.maxDimensionalAllowance,
      minDimensionalAllowance: currentRC.minDimensionalAllowance,
      measuredDimensions: currentRC.measuredDimensions,
      ambientHumidity: currentRC.ambientHumidity,
      ambientTemperature: currentRC.ambientTemperature,
    );

    sl<InterpreterController>().setCurrentRC(currentRC);
    sl<InterpreterController>().setCurrentModelInput(modelInput);
    Navigator.pushNamed(context, '/modelResult');
  }

  @override
  void initState() {
    _selectedRC = widget.selectedRC;
    _oldRcno = widget.selectedRC.rcno.toString();

    _initializeControllers();
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
                              required: true,
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
                      onPressed: _isPredictable ? () => _predictData(context) : null,
                      textData: "AI預測",
                    ),
                    const SizedBox(height: 20),
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
