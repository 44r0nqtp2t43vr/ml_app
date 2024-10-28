import 'package:get/get.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/features/predict_data/domain/model_input.dart';
import 'package:ml_app/features/predict_data/domain/model_output.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class InterpreterController extends GetxController {
  Interpreter? interpreterRough;
  Interpreter? interpreterFine;
  ModelInput? currentModelInput;
  ModelOutput? currentModelOutput;
  RC? currentRC;

  ModelInput? getCurrentModelInput() {
    return currentModelInput;
  }

  void setCurrentModelInput(ModelInput newModelInput) {
    currentModelInput = newModelInput;
  }

  ModelOutput? getCurrentModelOutput() {
    return currentModelOutput;
  }

  void setCurrentModelOutput(ModelOutput newModelOutput) {
    currentModelOutput = newModelOutput;
  }

  RC? getCurrentRC() {
    return currentRC;
  }

  void setCurrentRC(RC newRC) {
    currentRC = newRC;
  }

  void clearModelResults() {
    currentModelInput = null;
    currentModelOutput = null;
    currentRC = null;
  }

  Future<void> initializeInterpreter() async {
    interpreterRough = await Interpreter.fromAsset('assets/models/mlp_model_rough.tflite');
    interpreterFine = await Interpreter.fromAsset('assets/models/mlp_model_fine.tflite');
  }

  double convertHardness(String hardness) {
    if (hardness.startsWith('rb')) {
      return double.parse(hardness.substring(2));
    } else if (hardness.startsWith('rc')) {
      return double.parse(hardness.substring(2)) * 1.6 + 60;
    }
    return 0;
  }

  Future<void> predict() async {
    if (interpreterRough == null || interpreterFine == null || currentModelInput == null) {
      return;
    }

    currentModelInput!.machineYP02 = currentModelInput!.machine == "yp02" ? 1 : 0;
    currentModelInput!.machineYP03 = currentModelInput!.machine == "yp03" ? 1 : 0;
    currentModelInput!.hardness1RB = convertHardness(currentModelInput!.hardness1!);
    currentModelInput!.hardness2RB = convertHardness(currentModelInput!.hardness2!);
    var isRough = currentModelInput!.maxDimensionalAllowance! < 0.1 ? true : false;

    var input = [currentModelInput!.toList()];
    var output = List.filled(1 * 3, 0).reshape([1, 3]);

    if (isRough) {
      interpreterRough!.run(input, output);
    } else {
      interpreterFine!.run(input, output);
    }

    currentModelOutput = ModelOutput.fromList(output[0], isRough);
  }

  void replaceRCWithMO() {
    currentRC!.feedRate = currentModelOutput!.feedRate;
    currentRC!.spindleSpeedRough = currentModelOutput!.spindleSpeedRough ??= 0;
    currentRC!.spindleSpeedFine = currentModelOutput!.spindleSpeedFine ??= 0;
    currentRC!.spindleCurrent = currentModelOutput!.spindleCurrent;
  }
}
