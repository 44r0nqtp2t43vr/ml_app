import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class InterpreterController extends GetxController {
  Interpreter? interpreterRough;
  Interpreter? interpreterFine;
  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     final result = await permission.request();
  //     return result == PermissionStatus.granted;
  //   }
  // }

  Future<void> initializeInterpreter() async {
    interpreterRough = await Interpreter.fromAsset('assets/models/mlp_model_rough.tflite');
    interpreterFine = await Interpreter.fromAsset('assets/models/mlp_model_fine.tflite');
  }

  Future<void> predict() async {
    var input = [
      [0, 1, 95, 95, 58, 35, 72, 0.05, 0, 75.5]
    ];

    // if output tensor shape [1,2] and type is float32
    var output = List.filled(1 * 3, 0).reshape([1, 3]);

    // inference
    interpreterRough!.run(input, output);

    print(output);
  }
}
