import 'package:flutter/material.dart';
import 'package:ml_app/core/resources/formatters.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_list_view.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';

class Input2 extends StatefulWidget {
  const Input2({super.key});

  @override
  State<Input2> createState() => _Input2State();
}

class _Input2State extends State<Input2> {
  late RC _selectedRC;
  int _pageInd = 0;

  final _formKey = GlobalKey<FormState>();
  final _feedRateController = TextEditingController();
  final _spindleSpeedController = TextEditingController();
  final _cuttingVolumeController = TextEditingController();
  final _spindleCurrentController = TextEditingController();
  final _loadController = TextEditingController();

  final unfinishedRCs = [
    RC(rcno: "XXXXXXXXXX"),
  ];

  void _onSelectRC(RC selectedRC) {
    setState(() {
      _selectedRC = selectedRC;
      _pageInd++;
    });
  }

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_pageInd >= 1 && _pageInd <= 2) {
          _pageInd++;
        }
      });
    }
  }

  void _saveData(BuildContext context) {
    _selectedRC.date = dateTimeToString(DateTime.now());
    _selectedRC.feedRate = double.parse(_feedRateController.text.trim());
    _selectedRC.spindleSpeed = double.parse(_spindleSpeedController.text.trim());
    _selectedRC.cuttingVolume = double.parse(_cuttingVolumeController.text.trim());
    _selectedRC.spindleCurrent = double.parse(_spindleCurrentController.text.trim());
    _selectedRC.load = double.parse(_loadController.text.trim());

    print(_selectedRC.toMap());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Align(
          alignment: _pageInd == 0 ? Alignment.topCenter : Alignment.bottomCenter,
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
        title: "RC No.",
        itemCount: unfinishedRCs.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppButton(
              onPressed: () => _onSelectRC(unfinishedRCs[index]),
              textData: unfinishedRCs[index].rcno!,
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
