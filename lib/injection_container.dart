import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ml_app/core/controllers/files_controller.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies

  sl.registerSingleton<FilesController>(FilesController());

  Get.put<FilesController>(sl());

  // UseCases

  // Blocs
}
