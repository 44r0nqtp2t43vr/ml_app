import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_list_view.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/injection_container.dart';

class Input3 extends StatefulWidget {
  const Input3({super.key});

  @override
  State<Input3> createState() => _Input3State();
}

class _Input3State extends State<Input3> {
  late RC _selectedRC;
  bool _isLoadingRCs = true;
  bool _hasSelectedRC = false;
  List<dynamic> _unfinishedRCs = [];

  final _formKey = GlobalKey<FormState>();
  final _maxDimensionalAccuracyController = TextEditingController();
  final _minDimensionalAccuracyController = TextEditingController();
  final _surfaceRoughness1Controller = TextEditingController();
  final _surfaceRoughness2Controller = TextEditingController();
  final _surfaceRoughness3Controller = TextEditingController();
  final _roundnessController = TextEditingController();
  final _straightnessController = TextEditingController();

  Future<void> _initializeRCs() async {
    sl<FilesController>().getRCsList(ForScreen.input3).then((value) {
      setState(() {
        _unfinishedRCs = value;
        _isLoadingRCs = false;
      });
    });
  }

  void _onSelectRC(RC selectedRC) {
    setState(() {
      _selectedRC = selectedRC;
      _hasSelectedRC = true;
    });
  }

  void _saveData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _selectedRC.maxDimensionalAccuracy = double.parse(_maxDimensionalAccuracyController.text.trim());
        _selectedRC.minDimensionalAccuracy = double.parse(_minDimensionalAccuracyController.text.trim());
        _selectedRC.surfaceRoughness1 = double.parse(_surfaceRoughness1Controller.text.trim());
        _selectedRC.surfaceRoughness2 = double.parse(_surfaceRoughness2Controller.text.trim());
        _selectedRC.surfaceRoughness3 = double.parse(_surfaceRoughness3Controller.text.trim());
        _selectedRC.roundness = double.parse(_roundnessController.text.trim());
        _selectedRC.straightness = double.parse(_straightnessController.text.trim());
        _isLoadingRCs = true;
      });

      sl<FilesController>().writeCsvToDirectory(_selectedRC, isEdit: true).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  void initState() {
    _initializeRCs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingRCs
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Form(
              key: _formKey,
              child: _getBody(context),
            ),
    );
  }

  Widget _getBody(BuildContext context) {
    if (_hasSelectedRC) {
      return _inputData(context);
    } else {
      return _selectRC();
    }
  }

  Widget _selectRC() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AppListView(
        title: "批號",
        itemCount: _unfinishedRCs.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppButton(
              onPressed: () => _onSelectRC(_unfinishedRCs[index]),
              textData: _unfinishedRCs[index].rcno!,
            ),
          );
        },
      ),
    );
  }

  Widget _inputData(BuildContext context) {
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
            onPressed: () => _saveData(context),
            textData: "儲存",
          ),
        ],
      ),
    );
  }
}
