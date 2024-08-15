import 'package:flutter/material.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/features/input_data/presentation/pages/history/history.dart';
import 'package:ml_app/features/input_data/presentation/pages/input/input.dart';
import 'package:ml_app/features/input_data/presentation/pages/rc_details/rc_details.dart';
import 'package:ml_app/features/input_data/presentation/pages/select_input/select_input.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SelectInput());

      case '/input':
        return _materialRoute(const Input());

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
