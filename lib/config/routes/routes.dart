import 'package:flutter/material.dart';
import 'package:ml_app/features/input_data/presentation/pages/input_1/input_1.dart';
import 'package:ml_app/features/input_data/presentation/pages/select_input/select_input.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SelectInput());

      case '/input1':
        return _materialRoute(const Input1());

      default:
        return _materialRoute(const SelectInput());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view, maintainState: false);
  }
}
