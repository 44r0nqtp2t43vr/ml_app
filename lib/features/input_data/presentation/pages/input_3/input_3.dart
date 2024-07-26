import 'package:flutter/material.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_list_view.dart';
import 'package:ml_app/core/widgets/app_text_field.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';

class Input3 extends StatefulWidget {
  const Input3({super.key});

  @override
  State<Input3> createState() => _Input3State();
}

class _Input3State extends State<Input3> {
  late RC _selectedRC;
  int _pageInd = 0;

  final _formKey = GlobalKey<FormState>();
  final _dimensionalAccuracyController = TextEditingController();
  final _surfaceRoughnessController = TextEditingController();
  final _runoutController = TextEditingController();

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
    setState(() {
      if (_pageInd == 1) {
        _pageInd++;
      }
    });
  }

  void _saveData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _selectedRC.dimensionalAccuracy = double.parse(_dimensionalAccuracyController.text.trim());
      _selectedRC.surfaceRoughness = double.parse(_surfaceRoughnessController.text.trim());
      _selectedRC.runout = double.parse(_runoutController.text.trim());

      print(_selectedRC.toMap());
      Navigator.of(context).pop();
    }
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
        return _input3Page1();
      case 2:
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

  Widget _input3Page1() {
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
                controller: _dimensionalAccuracyController,
                errorText: "這是必需的",
                mainLabel: "尺寸精度",
                subLabel: "(mm)",
                dataType: DataType.double,
              ),
              const SizedBox(height: 40),
              AppTextField(
                controller: _surfaceRoughnessController,
                errorText: "這是必需的",
                mainLabel: "表面粗度",
                subLabel: "(μm)",
                dataType: DataType.double,
              ),
              const SizedBox(height: 40),
              AppTextField(
                controller: _runoutController,
                errorText: "這是必需的",
                mainLabel: "偏擺",
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
                    controller: _dimensionalAccuracyController,
                    errorText: "這是必需的",
                    mainLabel: "尺寸精度",
                    subLabel: "(mm)",
                    dataType: DataType.double,
                  ),
                  const SizedBox(height: 40),
                  AppTextField(
                    controller: _surfaceRoughnessController,
                    errorText: "這是必需的",
                    mainLabel: "表面粗度",
                    subLabel: "(μm)",
                    dataType: DataType.double,
                  ),
                  const SizedBox(height: 40),
                  AppTextField(
                    controller: _runoutController,
                    errorText: "這是必需的",
                    mainLabel: "偏擺",
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
