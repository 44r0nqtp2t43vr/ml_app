import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_list_view.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/injection_container.dart';

class Input2 extends StatefulWidget {
  const Input2({super.key});

  @override
  State<Input2> createState() => _Input2State();
}

class _Input2State extends State<Input2> {
  late RC _selectedRC;
  bool _isLoadingRCs = true;
  bool _hasSelectedRC = false;
  List<dynamic> _unfinishedRCs = [];

  final _formKey = GlobalKey<FormState>();
  final _feedRateController = TextEditingController();
  final _spindleSpeedRoughController = TextEditingController();
  final _spindleSpeedFineController = TextEditingController();
  final _cuttingVolumeController = TextEditingController();
  final _spindleCurrentController = TextEditingController();

  Future<void> _initializeRCs() async {
    sl<FilesController>().getRCsList(ForScreen.input2).then((value) {
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
        _selectedRC.feedRate = double.parse(_feedRateController.text.trim());
        _selectedRC.spindleSpeedRough = double.parse(_spindleSpeedRoughController.text.trim());
        _selectedRC.spindleSpeedFine = double.parse(_spindleSpeedFineController.text.trim());
        _selectedRC.cuttingVolume = double.parse(_cuttingVolumeController.text.trim());
        _selectedRC.spindleCurrent = double.parse(_spindleCurrentController.text.trim());
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
