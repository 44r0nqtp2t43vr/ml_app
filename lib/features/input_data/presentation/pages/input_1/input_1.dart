import 'package:flutter/material.dart';
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

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_pageInd == 0) {
          _newRC.rcno = _rcnoController.text;
          _newRC.material = _materialController.text;
          _newRC.supplier = _supplierController.text;
        }
        _pageInd++;
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 12.0,
                  bottom: 40.0,
                ),
                child: _getBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (_pageInd) {
      case 0:
        return _input1Page1();
      case 1:
        return _input1Page2();
      default:
        return _input1Page1();
    }
  }

  Widget _input1Page1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppTextField(
          controller: _rcnoController,
          errorText: "這是必需的",
          mainLabel: "批號",
          subLabel: "(mm)",
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
    );
  }

  Widget _input1Page2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        AppButton(
          onPressed: () => _nextPage(),
          textData: "下一頁",
        ),
      ],
    );
  }
}
