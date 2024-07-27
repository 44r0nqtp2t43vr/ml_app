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
  int _pageInd = 0;
  bool _isLoadingRCs = true;
  List<dynamic> _unfinishedRCs = [];

  final _formKey = GlobalKey<FormState>();
  final _feedRateController = TextEditingController();
  final _spindleSpeedController = TextEditingController();
  final _cuttingVolumeController = TextEditingController();
  final _spindleCurrentController = TextEditingController();
  final _loadController = TextEditingController();

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
      _pageInd++;
    });
  }

  void _nextPage() {
    setState(() {
      if (_pageInd >= 1 && _pageInd <= 2) {
        _pageInd++;
      }
    });
  }

  void _saveData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _selectedRC.feedRate = double.parse(_feedRateController.text.trim());
        _selectedRC.spindleSpeed = double.parse(_spindleSpeedController.text.trim());
        _selectedRC.cuttingVolume = double.parse(_cuttingVolumeController.text.trim());
        _selectedRC.spindleCurrent = double.parse(_spindleCurrentController.text.trim());
        _selectedRC.load = double.parse(_loadController.text.trim());
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
              child: Align(
                alignment: _pageInd == 0 ? Alignment.topLeft : Alignment.bottomCenter,
                child: _getBody(context),
              ),
            ),
    );
  }

  Widget _getBody(BuildContext context) {
    switch (_pageInd) {
      case 0:
        return _selectRC();
      case 1:
        return _input2Page1();
      case 2:
        return _input2Page2();
      case 3:
        return _verificationPage(context);
      default:
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

  Widget _input2Page1() {
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
                controller: _feedRateController,
                errorText: "這是必需的",
                mainLabel: "進給量",
                subLabel: "(m/min)",
                dataType: DataType.double,
              ),
              const SizedBox(height: 40),
              AppTextField(
                controller: _spindleSpeedController,
                errorText: "這是必需的",
                mainLabel: "主軸轉速",
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

  Widget _input2Page2() {
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
                controller: _spindleCurrentController,
                errorText: "這是必需的",
                mainLabel: "主軸電流",
                subLabel: "(A)",
                dataType: DataType.double,
              ),
              const SizedBox(height: 40),
              AppTextField(
                controller: _loadController,
                errorText: "這是必需的",
                mainLabel: "負載",
                subLabel: "(%)",
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
                    controller: _feedRateController,
                    errorText: "這是必需的",
                    mainLabel: "進給量",
                    subLabel: "(m/min)",
                    dataType: DataType.double,
                  ),
                  const SizedBox(height: 40),
                  AppTextField(
                    controller: _spindleSpeedController,
                    errorText: "這是必需的",
                    mainLabel: "主軸轉速",
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
                    controller: _loadController,
                    errorText: "這是必需的",
                    mainLabel: "負載",
                    subLabel: "(%)",
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
