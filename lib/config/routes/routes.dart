import 'package:flutter/material.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/features/input_data/presentation/pages/history/history.dart';
import 'package:ml_app/features/input_data/presentation/pages/input_1/input_1.dart';
import 'package:ml_app/features/input_data/presentation/pages/input_2/input_2.dart';
import 'package:ml_app/features/input_data/presentation/pages/input_3/input_3.dart';
import 'package:ml_app/features/input_data/presentation/pages/rc_details/rc_details.dart';
import 'package:ml_app/features/input_data/presentation/pages/select_input/select_input.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SelectInput());

      case '/input1':
        return _materialRoute(const Input1());

      case '/input2':
        return _materialRoute(const Input2());

      case '/input3':
        return _materialRoute(const Input3());

      case '/history':
        return _materialRoute(const History());

      case '/rcDetails':
        return _materialRoute(RCDetails(selectedRC: settings.arguments as RC));

      default:
        return _materialRoute(const SelectInput());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view, maintainState: false);
  }
}
