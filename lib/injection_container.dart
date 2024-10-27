import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/controllers/interpreter_controller.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies

  sl.registerSingleton<FilesController>(FilesController());

  Get.put<FilesController>(sl());

  sl.registerSingleton<InterpreterController>(InterpreterController());

  await Get.put<InterpreterController>(sl()).initializeInterpreter();

  // UseCases

  // Blocs
}
